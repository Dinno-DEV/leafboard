class_name CategorySpawner
extends Node

@export_group("Referenced nodes")
@export var add_category_button:Button
@export var category_buttons_container:Control
@export var soundboards_container:Control

signal category_created(category_name:String)

func _ready() -> void:
	if !add_category_button: return
	add_category_button.pressed.connect(_on_add_category_button_pressed)

func _on_add_category_button_pressed():
	if !category_buttons_container: return
	if !soundboards_container: return
	# get the new categ name
	DialogTextInput.reveal_dialogs()
	var response = await DialogTextInput.request_response("New category name", 24)
	while response[0].is_empty() and response[1]:
		DialogConfirmation.reveal_dialogs()
		await DialogConfirmation.request_response("Minimal one letter for category name.")
		DialogConfirmation.hide_dialogs()
		response = await DialogTextInput.request_response("New category name", 24)
	DialogTextInput.hide_dialogs()
	if !response[1]: return
	# adding new button and new soundboard to tree
	var new_category_name:String = response[0]
	add_new_category_button(new_category_name)
	CategoryChangesBroadcaster.announce_new_category(new_category_name)
	add_category_button.grab_focus()
	add_category_button.grab_click_focus()
	category_created.emit(new_category_name)

func is_category_exists(categ_name:String) -> bool:
	for button in category_buttons_container.get_children():
		if button is IdButton:
			if button.button_id == categ_name: return true
	return false

func add_new_category_button(new_category_name:String) -> void:
	# checks and warnings
	var check_is_passed:bool = true
	if is_category_exists(new_category_name): check_is_passed = false
	if !check_is_passed:
		DialogConfirmation.reveal_dialogs()
		await DialogConfirmation.request_response("Category \"" + new_category_name + "\" exists.")
		DialogConfirmation.hide_dialogs()
		add_category_button.grab_focus()
		add_category_button.grab_click_focus()
		return
	spawn_category_button(new_category_name)
	spawn_soundboard(new_category_name)

func spawn_category_button(new_category_name:String) -> CategoryButton: 
	var new_category_button:CategoryButton = preload("res://components/CategoryButton.tscn").instantiate()
	category_buttons_container.add_child(new_category_button)
	new_category_button.set_category_name_silent(new_category_name)
	category_buttons_container.visible = true
	return new_category_button

func spawn_soundboard(new_category_name:String) -> Soundboard:
	var new_soundboard:Soundboard = Soundboard.new()
	soundboards_container.add_child(new_soundboard)
	new_soundboard.set_soundboard_name(new_category_name)
	new_soundboard.visible = false
	return new_soundboard

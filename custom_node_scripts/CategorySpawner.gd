class_name CategorySpawner
extends Node

@export_group("Referenced nodes")
@export var add_category_button:Button
@export var category_buttons_container:Control
@export var soundboards_container:Control

func _ready() -> void:
	if !add_category_button: return
	add_category_button.pressed.connect(_on_add_category_button_pressed)

func _on_add_category_button_pressed():
	if !category_buttons_container: return
	if !soundboards_container: return
	# get the new categ name
	DialogTextInput.reveal_dialogs()
	var response = await DialogTextInput.request_response("New category name")
	DialogTextInput.hide_dialogs()
	if !response[1]: return
	# adding new button and new soundboard to tree
	var new_category_name:String = response[0]
	add_new_category_button(new_category_name)
	CategoryChangesBroadcaster.announce_new_category(new_category_name)

func add_new_category_button(new_category_name:String) -> void:
	var new_category_button:CategoryButton = preload("res://components/CategoryButton.tscn").instantiate()
	category_buttons_container.add_child(new_category_button)
	new_category_button.set_category_name_silent(new_category_name)

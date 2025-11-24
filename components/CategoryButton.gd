class_name CategoryButton
extends IdButton

@export_group("Referenced Nodes")
@export var delete_button:Button
@export var edit_button:Button

func _ready() -> void:
	delete_button.pressed.connect(_on_delete_button_pressed)
	edit_button.pressed.connect(_on_edit_button_pressed)
	pressed.connect(_on_pressed)

func get_category_name() -> String:
	return text

func set_category_name(new_name:String) -> void:
	CategoryChangesBroadcaster.announce_name_change(get_category_name(), new_name)
	text = new_name
	button_id = new_name

func set_category_name_silent(new_name:String) -> void:
	text = new_name
	button_id = new_name

func _on_delete_button_pressed() -> void:
	DialogConfirmation.reveal_dialogs()
	if await DialogConfirmation.request_response("Are you sure?"):
		CategoryChangesBroadcaster.announce_deleted(get_category_name())
		self.queue_free()
	DialogConfirmation.hide_dialogs()

func _on_edit_button_pressed() -> void:
	DialogTextInput.reveal_dialogs()
	var response:Array = await DialogTextInput.request_response("New name", 24)
	if response[0].is_empty() and response[1]:
		DialogConfirmation.reveal_dialogs()
		await DialogConfirmation.request_response("Minimal one letter for category name.")
		DialogConfirmation.hide_dialogs()
		DialogTextInput.hide_dialogs()
		return
	if is_category_exists(response[0]):
		DialogConfirmation.reveal_dialogs()
		await DialogConfirmation.request_response("Category \"" + response[0] + "\" exists.")
		DialogConfirmation.hide_dialogs()
		DialogTextInput.hide_dialogs()
		return
	if response[1]: set_category_name(response[0])
	DialogTextInput.hide_dialogs()

func is_category_exists(categ_name:String) -> bool:
	var category_buttons_container:Node = get_parent()
	if category_buttons_container is not Selector: return false
	for button in category_buttons_container.get_children():
		if button is IdButton:
			if button.button_id == categ_name: return true
	return false

func _on_pressed() -> void:
	pressed_id.emit(button_id)

func _on_mouse_exited() -> void:
	delete_button.visible = false
	edit_button.visible = false

func _on_mouse_entered() -> void:
	if button_pressed: return
	delete_button.visible = true
	edit_button.visible = true

func _on_button_down() -> void:
	delete_button.visible = false
	edit_button.visible = false

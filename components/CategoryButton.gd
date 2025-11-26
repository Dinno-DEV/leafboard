class_name CategoryButton
extends IdButton

@export var reordering_margin:int = 9
@export_group("Referenced Nodes")
@export var delete_button:Button
@export var edit_button:Button

var is_reordering:bool = false

signal reordered(prev_index:int, new_index:int)

func _ready() -> void:
	delete_button.pressed.connect(_on_delete_button_pressed)
	edit_button.pressed.connect(_on_edit_button_pressed)

func _process(_delta: float) -> void:
	if is_reordering:
		if !Input.is_action_pressed("mouse_left"):
			stop_moving(); return
		if get_local_mouse_position().y < 0 - reordering_margin:
			if get_index() - 1 >= 0:
				if get_parent():
					reordered.emit(get_index(), get_index()-1)
					get_parent().move_child(self, get_index() - 1)
		if get_local_mouse_position().y > size.y + reordering_margin:
			if get_index() + 1 <= get_parent().get_child_count() - 1:
				if get_parent():
					reordered.emit(get_index(), get_index()+1)
					get_parent().move_child(self, get_index() + 1)

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

func start_moving() -> void: is_reordering = true
func stop_moving() -> void: is_reordering = false

func _on_mouse_exited() -> void:
	delete_button.visible = false
	edit_button.visible = false

func _on_mouse_entered() -> void:
	if selected: return
	delete_button.visible = true
	edit_button.visible = true

func _on_button_down() -> void:
	pressed_id.emit(button_id)
	delete_button.visible = false
	edit_button.visible = false
	# await so it prevents moving before loading the soundboard
	await get_tree().create_timer(0.1).timeout
	start_moving()

func _on_button_up() -> void:
	stop_moving()

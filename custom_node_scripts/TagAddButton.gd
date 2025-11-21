class_name TagAddButton
extends Button

func _ready() -> void:
	theme_type_variation = "ButtonTagAddRad8"
	icon = preload("res://assets/icons/Add.png")
	icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	expand_icon = true
	custom_minimum_size = Vector2(18,18)
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	var parent = get_parent()
	# parent type validation
	if parent is not Control: return
	# getting name from player
	DialogTextInput.reveal_dialogs()
	var response = await DialogTextInput.request_response("Tag Name",15)
	DialogTextInput.hide_dialogs()
	grab_focus()
	if !response[1]: return
	# check if empty:
	if response[0].is_empty(): return
	# check for duplicate tag name
	if parent is TagContainer:
		if parent.has_tag(response[0]): return
	# adds tag
	var tag_button:TagButton = TagButton.new()
	tag_button.tag_name = response[0]
	parent.add_child(tag_button)
	parent.move_child(self, get_parent().get_child_count()-1)

class_name CategoryButton
extends IdButton

@export_group("Referenced Nodes")
@export var delete_button:Button
@export var edit_button:Button

func _on_toggled(toggled_on: bool) -> void:
	if !delete_button and !edit_button: return
	match toggled_on:
		true: delete_button.visible = false; edit_button.visible = false
		false: delete_button.visible = true; edit_button.visible = true

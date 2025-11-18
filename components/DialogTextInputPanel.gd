class_name DialogTextInputPanel
extends PanelContainer

@export var place_holder_text:String = ""
@export_group("Referenced Nodes")
@export var confirm_button:Button
@export var cancel_button:Button
@export var line_edit:LineEdit

signal response_received(response:String, is_confirmed:bool)

func _ready() -> void:
	confirm_button.pressed.connect(_on_confirm_button_pressed)
	cancel_button.pressed.connect(_on_cancel_button_pressed)
	line_edit.text_submitted.connect(_on_text_submitted)
	if place_holder_text != "": setup_dialog(place_holder_text)

func setup_dialog(message:String):
	set_message(message)
	confirm_button.disabled = false
	cancel_button.disabled = false
	await get_tree().create_timer(0.1).timeout
	line_edit.grab_focus()
	line_edit.grab_click_focus()

func set_message(message:String):
	line_edit.placeholder_text = message

func _on_confirm_button_pressed():
	response_received.emit(line_edit.text, true)

func _on_cancel_button_pressed():
	response_received.emit(line_edit.text, false)

func _on_text_submitted(_text:String):
	confirm_button.grab_focus()
	confirm_button.grab_click_focus()

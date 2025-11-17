class_name DialogConfirmPanel
extends PanelContainer

@export var dialog_message:String = ""
@export_group("Referenced Nodes")
@export var confirm_button:Button
@export var cancel_button:Button
@export var text_label:Label

signal received_response(is_confirmed:bool)

func _ready() -> void:
	confirm_button.pressed.connect(_on_confirm_button_pressed)
	cancel_button.pressed.connect(_on_cancel_button_pressed)
	get_player_response(dialog_message)

func get_player_response(message:String) -> void:
	set_dialog_message(message)
	confirm_button.disabled = false
	cancel_button.disabled = false

func set_dialog_message(message) -> void:
	text_label.text = message

func _on_confirm_button_pressed():
	received_response.emit(true)
	print("confirm")

func _on_cancel_button_pressed():
	received_response.emit(false)
	print("cancel")

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
	# auto start panel if dialog message is not empty
	if dialog_message != "":
		setup_dialog(dialog_message)

func setup_dialog(message:String) -> void:
	set_dialog_message(message)
	confirm_button.disabled = false
	cancel_button.disabled = false

func set_dialog_message(message:String) -> void:
	text_label.text = message

func _on_confirm_button_pressed():
	received_response.emit(true)

func _on_cancel_button_pressed():
	received_response.emit(false)

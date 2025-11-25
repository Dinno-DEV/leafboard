class_name IdButton
extends Button

@export var button_id:String

var selected:bool = false

signal pressed_id(id:String)

func _ready() -> void:
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	pressed_id.emit(button_id)

class_name TagButton
extends Button

@export var tag_name:String

func _ready() -> void:
	theme_type_variation = "ButtonTagRad8"
	if !tag_name.is_empty():
		set_tag_name(tag_name)
	pressed.connect(_on_pressed)

func set_tag_name(new_name:String) -> void:
	name = new_name
	tag_name = new_name
	text = new_name

func _on_pressed() -> void:
	queue_free()

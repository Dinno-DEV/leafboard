class_name CategoryButtonDataCollector
extends Node

func _ready() -> void:
	var parent:Node = get_parent()
	if parent is CategoryButton:
		parent.reordered.connect(_on_parent_reordered)

func _on_parent_reordered(prev:int, new:int) -> void:
	AppMemory.move_soundboard_button(prev, new)
	Saver.save_soundboards_data()

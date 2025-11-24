class_name CategorySpawnerDataCollector
extends Node

func _ready() -> void:
	var parent:Node = get_parent()
	if parent is CategorySpawner:
		parent.category_created.connect(_on_category_created)

func _on_category_created(new_category_name:String) -> void:
	AppMemory.set_soundboard(new_category_name, [])
	Saver.save_soundboards_data()

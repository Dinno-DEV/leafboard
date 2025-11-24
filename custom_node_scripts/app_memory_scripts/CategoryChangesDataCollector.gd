class_name CategoryChangesDataCollector
extends Node

func _ready() -> void:
	CategoryChangesBroadcaster.category_name_changed.connect(_on_category_name_changed)
	CategoryChangesBroadcaster.category_deleted.connect(_on_category_deleted)

func _on_category_name_changed(prev_name:String, new_name:String) -> void:
	AppMemory.set_soundboard_name(prev_name, new_name)
	print(prev_name, new_name)

func _on_category_deleted(category_name:String) -> void:
	AppMemory.delete_soundboard(category_name)
	print(category_name)

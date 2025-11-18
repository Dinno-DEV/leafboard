extends Node

signal category_name_changed(previous_name:String, new_name:String)

func announce_name_change(previous_name:String, new_name:String) -> void:
	category_name_changed.emit(previous_name, new_name)

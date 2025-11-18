extends Node

signal category_name_changed(previous_name:String, new_name:String)
signal category_deleted(category_name:String)
signal category_repositioned(category_name:String, new_position:int)

func announce_name_change(previous_name:String, new_name:String) -> void:
	category_name_changed.emit(previous_name, new_name)

func announce_deleted(category_name:String):
	category_deleted.emit(category_name)

func announce_repositioned(category_name:String, new_position:int):
	category_repositioned.emit(category_name, new_position)

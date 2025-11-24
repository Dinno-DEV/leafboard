class_name SoundButtonDataCollector
extends Node

func _ready() -> void:
	var parent = get_parent()
	if parent is SoundboardButton:
		parent.button_edited.connect(_on_soundboard_button_edited)
		parent.button_moved.connect(_on_button_moved)
		parent.button_deleted.connect(_on_button_deleted)

func _on_button_deleted() -> void:
	var grandparent = get_parent().get_parent()
	if grandparent is not Soundboard: return
	AppMemory.delete_audio_button(grandparent.get_soundboard_name(), get_parent().get_index())
	Saver.save_soundboards_data()

func _on_button_moved(new_index:int, previous_index:int) -> void:
	var grandparent = get_parent().get_parent()
	if grandparent is not Soundboard: return
	AppMemory.move_audio_button(grandparent.get_soundboard_name(), previous_index, new_index)
	Saver.save_soundboards_data()

func _on_soundboard_button_edited(new_button_data:Dictionary) -> void:
	var grandparent = get_parent().get_parent()
	if grandparent is not Soundboard: return
	AppMemory.set_audio_button(grandparent.get_soundboard_name(), new_button_data, get_parent().get_index())
	Saver.save_soundboards_data()

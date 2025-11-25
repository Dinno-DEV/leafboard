class_name SearchShortcutExecutor
extends Node

@export_group("Referenced Nodes")
@export var search:SoundboardSearcher
@export var tag_search:TagAddButton

func _shortcut_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("focus_search"):
		search.edit()
		get_viewport().set_input_as_handled()
	if Input.is_action_just_pressed("new_search_tag"):
		tag_search._on_pressed()

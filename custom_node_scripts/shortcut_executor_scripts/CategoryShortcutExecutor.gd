class_name CategoryShortcutExecutor
extends Node

@export_group("Referenced Nodes")
@export var category_spawner:CategorySpawner
@export var selector:Selector

func _shortcut_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("new_category"):
		category_spawner._on_add_category_button_pressed()
	if Input.is_action_just_pressed("prev_category"):
		var current_selected:IdButton = selector.get_current_selected()
		var selected_index:int = current_selected.get_index()
		if selected_index - 1 < 0: return
		var prev_id:String = selector.get_child(selected_index-1).button_id
		selector.select(prev_id)
		selector.selected.emit(prev_id)
	if Input.is_action_just_pressed("next_category"):
		var current_selected:IdButton = selector.get_current_selected()
		var selected_index:int = current_selected.get_index()
		if selected_index + 1 > selector.get_child_count() - 1: return
		var next_id:String = selector.get_child(selected_index+1).button_id
		selector.select(next_id)
		selector.selected.emit(next_id)

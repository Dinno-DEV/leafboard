@tool
class_name SquarePanelContainer
extends PanelContainer

@export var is_following_width:bool = true
@export var flow_container_uniform:bool = true

@onready var initial_h_flag = size_flags_horizontal
@onready var initial_v_flag = size_flags_vertical
@onready var initial_custom_minimum_size = custom_minimum_size

func get_parent_flow_row() -> int:
	var result:int = 0
	var parent = get_parent()
	var current_line_coord:int = 0
	var current_division:int = 0
	var highest_division:int = 0
	if parent is not FlowContainer: return -1
	for child in parent.get_children():
		if child is SquarePanelContainer:
			if current_line_coord < int(child.position.y):
				if current_division > highest_division:
					highest_division = current_division
				current_division = 0
			else:
				current_division += 1
			current_line_coord = int(child.position.y)
			if parent.vertical: current_line_coord = int(child.position.x)
	result = highest_division
	return result

func is_all_sibling_square_panel() -> bool:
	for child in get_parent().get_children():
		if child is not SquarePanelContainer: return false
	return true

func _process(_delta: float) -> void:
	if flow_container_uniform and is_all_sibling_square_panel() and get_index() != 0:
		var parent = get_parent()
		custom_minimum_size = initial_custom_minimum_size
		size_flags_horizontal = initial_h_flag
		size_flags_vertical = initial_v_flag
		if parent is FlowContainer:
			if get_parent_flow_row() != 0:
				var trailing_child_count:int = parent.get_child_count() % get_parent_flow_row()
				if get_index() > parent.get_child_count() - trailing_child_count - 1:
					if parent.vertical: size_flags_vertical = Control.SIZE_SHRINK_BEGIN
					else: size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
					custom_minimum_size = parent.get_child(0).size
					size = parent.get_child(0).size
	if is_following_width:
		size.y = size.x
		custom_minimum_size.y = size.x
	else:
		size.x = size.y
		custom_minimum_size.x = size.y

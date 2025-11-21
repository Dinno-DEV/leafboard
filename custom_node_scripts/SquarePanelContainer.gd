@tool
class_name SquarePanelContainer
extends PanelContainer

@export var is_following_width:bool = true
@export var allow_reordering:bool = false
@export var is_reordering:bool = false
@export var initial_h_flag:SizeFlags = SIZE_EXPAND_FILL
@export var initial_v_flag:SizeFlags = SIZE_SHRINK_BEGIN
@export var initial_custom_minimum_size:Vector2 = Vector2(150,150)
@export var flow_container_uniform:bool = true
var container_size_threshold:Vector2

func get_parent_flow_row() -> int:
	var result:int = 0
	var parent = get_parent()
	var current_line_coord:int = 0
	var current_division:int = 0
	var highest_division:int = 0
	if parent is not FlowContainer: return -1
	# find the row count based on children's y position
	for child in parent.get_children():
		if child is SquarePanelContainer:
			if current_line_coord < int(child.position.y):
				# reset at the end of the row
				if current_division > highest_division:
					highest_division = current_division
				current_division = 0
			else:
				if child.visible: current_division += 1
			current_line_coord = int(child.position.y)
			if parent.vertical: current_line_coord = int(child.position.x)
	if current_division > highest_division:
		highest_division = current_division
	result = highest_division
	return result

func is_all_sibling_square_panel() -> bool:
	for child in get_parent().get_children():
		if child is not SquarePanelContainer: return false
	return true

func get_total_panel_width() -> float:
	var parent = get_parent()
	if !parent: return -1
	if parent is HFlowContainer:
		return get_parent_flow_row() * parent.get_theme_constant("h_separation") + get_parent_flow_row() * initial_custom_minimum_size.x
	else: return -1

func get_total_panel_height() -> float:
	var parent = get_parent()
	if !parent: return -1
	if parent is HFlowContainer:
		return get_parent_flow_row() * parent.get_theme_constant("v_separation") + get_parent_flow_row() * initial_custom_minimum_size.y
	else: return -1

func _process(_delta: float) -> void:
	if !get_parent() or get_parent() is not Control: return
	custom_minimum_size = initial_custom_minimum_size
	size_flags_horizontal = initial_h_flag
	size_flags_vertical = initial_v_flag
	if flow_container_uniform and is_all_sibling_square_panel():
		var parent = get_parent()
		if parent is FlowContainer:
			container_size_threshold = parent.size - initial_custom_minimum_size
			if parent.vertical:
				if get_total_panel_height() < container_size_threshold.y:
					size_flags_vertical = SIZE_SHRINK_BEGIN
			else:
				if get_total_panel_width() < container_size_threshold.x:
					size_flags_horizontal = SIZE_SHRINK_BEGIN
			if get_index() != 0:
				if get_parent_flow_row() != 0 and parent.get_line_count() > 1:
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
	# for reordering stuff. This is black magic. I haven't
	# figured out how to tidy it up without sacrificing modularity.
	if flow_container_uniform and is_all_sibling_square_panel():
		var parent = get_parent()
		if parent is FlowContainer:
			if allow_reordering and is_reordering:
				await get_tree().physics_frame
				var local_mouse_pos = get_local_mouse_position()
				if local_mouse_pos.x < 0 - parent.get_theme_constant("h_separation") and get_index() - 1 >= 0:
					if get_index() % get_parent_flow_row() != 0:
						get_parent().move_child(self, get_index()-1)
				elif local_mouse_pos.x > size.x + parent.get_theme_constant("h_separation") and get_index() < get_parent().get_child_count():
					if (get_index() + 1) % get_parent_flow_row() != 0:
						get_parent().move_child(self, get_index()+1)
				elif local_mouse_pos.y < 0 - parent.get_theme_constant("v_separation") and get_index() - get_parent_flow_row() >= 0:
					get_parent().move_child(self, get_index() - get_parent_flow_row())
				elif local_mouse_pos.y > size.y + parent.get_theme_constant("v_separation")  and get_index() + get_parent_flow_row() < get_parent().get_child_count():
					get_parent().move_child(self, get_index() + get_parent_flow_row())

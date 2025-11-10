extends Node

func get_delta_from_pos(click_position:Vector2) -> Vector2:
	return get_viewport().get_mouse_position() - click_position

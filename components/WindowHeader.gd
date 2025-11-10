class_name WindowHeader
extends Control

var is_mouse_in:bool = false
var is_repositioning:bool = false
var click_position:Vector2

func _process(_delta: float) -> void:
	if is_mouse_in && Input.is_action_just_pressed("mouse_left_click"):
		is_repositioning = true
		click_position = get_viewport().get_mouse_position()
	if Input.is_action_just_released("mouse_left_click"):
		is_repositioning = false
	if is_repositioning:
		get_window().position += Vector2i(MouseUtil.get_delta_from_pos(click_position))
		# prevents window to go below taskbar
		if get_window().position.y > DisplayServer.screen_get_size().y - 150:
			get_window().position.y = DisplayServer.screen_get_size().y - 150

func _on_mouse_entered() -> void:
	is_mouse_in = true

func _on_mouse_exited() -> void:
	is_mouse_in = false

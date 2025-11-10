class_name WindowHeader
extends Control

@export_group("Referenced Nodes")
@export var main_scene_background:PanelContainer
@export var window_mode_button:IdButton

var is_mouse_in:bool = false
var is_repositioning:bool = false
var is_maximized:bool = false
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

func _on_minimize_pressed_id(_id: String) -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)

func _on_window_mode_pressed_id(_id: String) -> void:
	if is_maximized: is_maximized = false; DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else: is_maximized = true; DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	if is_maximized and main_scene_background != null:
		main_scene_background.theme_type_variation = "PanelContainerMainRad0"
		if window_mode_button != null:
			window_mode_button.icon = preload("res://assets/icons/Windowed.png")
	else:
		main_scene_background.theme_type_variation = "PanelContainerMainRad10"
		if window_mode_button != null:
			window_mode_button.icon = preload("res://assets/icons/Maximize.png")

func _on_close_pressed_id(_id: String) -> void:
	get_tree().quit()

extends CanvasLayer

func _ready() -> void:
	get_window().min_size = Vector2(854,480)

func _process(_delta: float) -> void:
	if get_window().mode == DisplayServer.WINDOW_MODE_MAXIMIZED:
		self.visible = false
	else:
		self.visible = true

func _on_top_left_side_button_down() -> void:
	get_window().start_resize(DisplayServer.WINDOW_EDGE_TOP_LEFT)

func _on_left_side_button_down() -> void:
	get_window().start_resize(DisplayServer.WINDOW_EDGE_LEFT)

func _on_bottom_left_side_button_down() -> void:
	get_window().start_resize(DisplayServer.WINDOW_EDGE_BOTTOM_LEFT)

func _on_top_button_down() -> void:
	get_window().start_resize(DisplayServer.WINDOW_EDGE_TOP)

func _on_bottom_button_down() -> void:
	get_window().start_resize(DisplayServer.WINDOW_EDGE_BOTTOM)

func _on_top_right_button_down() -> void:
	get_window().start_resize(DisplayServer.WINDOW_EDGE_TOP_RIGHT)

func _on_right_side_button_down() -> void:
	get_window().start_resize(DisplayServer.WINDOW_EDGE_RIGHT)

func _on_bottom_right_button_down() -> void:
	get_window().start_resize(DisplayServer.WINDOW_EDGE_BOTTOM_RIGHT)

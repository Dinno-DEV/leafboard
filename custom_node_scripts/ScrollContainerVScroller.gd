class_name ScrollContainerVScroller
extends VScrollBar

@export var scroll_container:ScrollContainer

func _ready() -> void:
	value_changed.connect(_on_value_changed)

func _process(_delta: float) -> void:
	if !scroll_container: return
	var _single_child:Control
	for child in scroll_container.get_children():
		if child is Control:
			if child.visible:
				_single_child = child
				break
	max_value = _single_child.size.y
	page = scroll_container.size.y
	set_value_no_signal(scroll_container.scroll_vertical)

func _on_value_changed(new_value:float) -> void:
	scroll_container.scroll_vertical = int(new_value)

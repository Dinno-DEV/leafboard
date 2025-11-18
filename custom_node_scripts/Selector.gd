class_name Selector
extends BoxContainer

@export var select_on_ready:int = -1

signal selected(id:String)

func _ready() -> void:
	set_all_button_toggle_mode()
	disable_all_non_id_button()
	# get all the idbuttons and its descendants
	var id_buttons:Array[Node] = NodeFilterer.by_type(get_children(), "IdButton")
	id_buttons.append_array(NodeFilterer.by_type(get_children(), "CategoryButton"))
	# connecting idbuttons' signal to this node
	for id_button in id_buttons:
		id_button.pressed_id.connect(_on_id_button_pressed_id)
	# the thing to select on ready
	if select_on_ready != -1:
		if get_child(select_on_ready) is IdButton: 
			select(get_child(select_on_ready).button_id)

func set_all_button_toggle_mode() -> void:
	for node in get_children():
		if node is Button:
			node.toggle_mode = true

func disable_all_non_id_button() -> void:
	for node in get_children():
		if node is not IdButton && node is Button:
			node.disabled = true

func unselect_all() -> void:
	for node in get_children():
		if node is Button:
			node.button_pressed = false

func select(id:String) -> void:
	unselect_all()
	for node in get_children():
		if node is IdButton:
			if node.button_id == id:
				node.button_pressed = true

func _on_id_button_pressed_id(id:String):
	selected.emit(id)
	select(id)

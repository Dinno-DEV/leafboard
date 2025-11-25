class_name Selector
extends BoxContainer

@export var select_on_ready:int = -1

signal selected(id:String)

func _ready() -> void:
	child_entered_tree.connect(_on_child_entered_tree)
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
			selected.emit(get_child(select_on_ready).button_id)
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
			if node.theme_type_variation == "ButtonRad12Selected":
				node.theme_type_variation = "ButtonRad12"
			node.button_pressed = false
			if node is IdButton: node.selected = false

func select(id:String) -> void:
	unselect_all()
	for node in get_children():
		if node is IdButton:
			if node.button_id == id:
				if node.theme_type_variation == "ButtonRad12":
					node.theme_type_variation = "ButtonRad12Selected"
				node.button_pressed = true
				node.selected = true

func get_button_id(index:int) -> String:
	if get_child(index) is not IdButton: return ""
	return get_child(index).button_id

func _on_id_button_pressed_id(id:String):
	selected.emit(id)
	select(id)

func _on_child_entered_tree(child:Node) -> void:
	if child is IdButton:
		child.pressed_id.connect(_on_id_button_pressed_id)

class_name ContentSwitcherContainer
extends PanelContainer

@export var unload_unselected:bool = true
@export_group("Referenced Nodes")
@export var selector:Selector

var stored_nodes:Array[Node] = []

signal content_switched(new_selected_node:Node)
signal content_shown(node:Node)

func _ready() -> void:
	hide_all_content()
	show_first_content()
	if !selector: 
		printerr("[ContentSwitcherContainer|", self.name,"] Selector has not been defined.")
		return
	selector.selected.connect(_on_selector_selected)

func show_first_content() -> void:
	for node in get_children():
		if node is Control:
			node.visible = true
			return

func hide_all_content() -> void:
	for node in get_children():
		if node is Control:
			node.visible = false
			if unload_unselected:
				stored_nodes.append(node)
				remove_child(node)

func show_content(id:String) -> void:
	if unload_unselected:
		for node in stored_nodes:
			if node.name == id: add_child(node)
	var filter_result:Node = NodeFilterer.by_name(get_children(), id)
	if filter_result is Control: filter_result.visible = true
	content_shown.emit(filter_result)

func get_selected_node() -> Node:
	for child in get_children():
		if child.visible: return child
	return null

func _on_selector_selected(id:String) -> void:
	hide_all_content()
	show_content(id)
	content_switched.emit(NodeFilterer.by_name(get_children(), id))

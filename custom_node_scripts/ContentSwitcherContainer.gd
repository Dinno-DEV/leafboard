class_name ContentSwitcherContainer
extends PanelContainer

@export_group("Referenced Nodes")
@export var selector:Selector

signal content_switched(new_selected_node:Node)

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

func show_content(id:String) -> void:
	var filter_result:Node = NodeFilterer.by_name(get_children(), id)
	if filter_result is Control: filter_result.visible = true

func get_selected_node() -> Node:
	for child in get_children():
		if child.visible: return child
	return null

func _on_selector_selected(id:String) -> void:
	hide_all_content()
	show_content(id)
	content_switched.emit(NodeFilterer.by_name(get_children(), id))

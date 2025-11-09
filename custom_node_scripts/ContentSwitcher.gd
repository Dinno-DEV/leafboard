class_name ContentSwitcher
extends Control

@export_group("Referenced Nodes")
@export var selector:Selector

func _ready() -> void:
	hide_all_content()
	show_first_content()
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

func _on_selector_selected(id:String) -> void:
	hide_all_content()
	show_content(id)

class_name SelectorTitleDisplayer
extends Label

@export var prefix:String = ""
@export var suffix:String = ""
@export_group("Referenced Nodes")
@export var selector:Selector

func _ready() -> void:
	if selector.select_on_ready != -1:
		_on_selector_selected(selector.get_button_id(selector.select_on_ready))
	if selector:
		selector.selected.connect(_on_selector_selected)

func _on_selector_selected(id:String) -> void:
	text = prefix + id + suffix

class_name SelectorTitleDisplayer
extends Label

@export var prefix:String = ""
@export var suffix:String = ""
@export_group("Referenced Nodes")
@export var selector:Selector

func _ready() -> void:
	if selector:
		selector.selected.connect(_on_selector_selected)

func _on_selector_selected(id:String) -> void:
	text = prefix + id + suffix

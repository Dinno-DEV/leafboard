class_name TagContainer
extends FlowContainer

signal tag_added(new_tag:String)
signal tag_removed(removed_tag:String)

func _ready() -> void:
	child_entered_tree.connect(_on_child_entered)
	child_exiting_tree.connect(_on_child_exited)

func get_all_tags() -> Array[String]:
	var result:Array[String] = []
	for child in get_children():
		if child is TagButton:
			result.append(child.tag_name)
	return result

func has_tag(tag_name:String) -> bool:
	return tag_name in get_all_tags()

func _on_child_entered(node:Node) -> void:
	if node is TagButton: tag_added.emit(node.tag_name)

func _on_child_exited(node:Node) -> void:
	if node is TagButton: tag_removed.emit(node.tag_name)

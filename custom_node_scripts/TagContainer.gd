class_name TagContainer
extends FlowContainer

func get_all_tags() -> Array[String]:
	var result:Array[String] = []
	for child in get_children():
		if child is TagButton:
			result.append(child.tag_name)
	return result

func has_tag(tag_name:String) -> bool:
	return tag_name in get_all_tags()

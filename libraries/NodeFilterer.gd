class_name NodeFilterer
extends Node

static func by_name_beginning(nodes:Array[Node], node_name:String) -> Array[Node]:
	var filter_result:Array[Node] = []
	for node in nodes:
		if node.name.begins_with(node_name): filter_result.append(node)
	return filter_result

static func by_name_ending(nodes:Array[Node], node_name:String) -> Array[Node]:
	var filter_result:Array[Node] = []
	for node in nodes:
		if node.name.ends_with(node_name): filter_result.append(node)
	return filter_result

static func by_name(nodes:Array[Node], node_name:String) -> Node:
	for node in nodes:
		if node.name == node_name: return node
	return null

static func by_type(nodes:Array[Node], node_type:String) -> Array[Node]:
	var filter_result:Array[Node] = []
	for node in nodes:
		if node.is_class(node_type): filter_result.append(node)
	return filter_result

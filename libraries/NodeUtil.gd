class_name NodeUtil
extends Node

# by godot forum user: "wchc"
static func get_type_as_string(object: Object) -> String:
	if object == null:
		return ""
	var script: Script = object.get_script()
	if script == null:
		return object.get_class()
	var type_as_string: String = script.get_global_name()
	if type_as_string == "":
		type_as_string = script.get_instance_base_type()
	return type_as_string

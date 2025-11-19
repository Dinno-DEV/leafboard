class_name Soundboard
extends HFlowContainer

func add_new_button(id:String, sound:AudioStreamMP3) -> void:
	return

func delete_button(id:String):
	return

func get_soundboard_name() -> String:
	return name

func get_all_button_id() -> Array:
	return []

func get_button_volume(id:String) -> int:
	return 0

func get_button_tags(id:String) -> Array[String]:
	return []

func get_now_playing() -> Array[String]:
	return []

func get_button_by_id(id:String):
	return id

func set_soundboard_name(new_name:String) -> void:
	name = new_name

func set_button_visible(id:String):
	return id

func set_button_size() -> void:
	pass

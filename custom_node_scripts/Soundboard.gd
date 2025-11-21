class_name Soundboard
extends HFlowContainer

func tester():
	var names:Array[String] = ["aaa", "bbb", "ccc", "ddd"]
	var path:String = "res://assets/audio/wow_2.mp3"
	for the_name in names:
		add_new_button(the_name, path)

func add_new_button(id:String, sound_path:String) -> void:
	var sound_button:SoundboardButton = preload("res://components/SoundboardButton.tscn").instantiate()
	sound_button.set_button_data(id, sound_path, 50, [])
	add_child(sound_button)

func delete_button(id:String):
	for child in get_children():
		if child is SoundboardButton:
			if child.get_button_name() == id:
				child.queue_free()

func get_soundboard_name() -> String:
	return name

func get_all_button_id() -> Array[String]:
	var result:Array[String] = []
	for child in get_children():
		if child is SoundboardButton:
			result.append(child.get_button_name())
	return result

func get_button_volume(id:String) -> float:
	return get_button_by_id(id).get_button_volume()

func get_button_tags(id:String) -> Array[String]:
	return get_button_by_id(id).get_button_tags()

func get_now_playing() -> Array[String]:
	var result:Array[String] = []
	for child in get_children():
		if child is SoundboardButton:
			if child.is_playing(): result.append(child.get_button_name())
	return result

func get_button_by_id(id:String) -> SoundboardButton:
	for child in get_children():
		if child is SoundboardButton:
			if child.get_button_name() == id: return child
	return null

func set_soundboard_name(new_name:String) -> void:
	name = new_name

func set_button_visible(id:String) -> void:
	get_button_by_id(id).visible = true

func set_button_invisible(id:String) -> void:
	get_button_by_id(id).visible = false

func set_all_buttons_visible() -> void:
	for child in get_children():
		if child is SoundboardButton: child.visible = true

func set_all_buttons_invisible() -> void:
	for child in get_children():
		if child is SoundboardButton: child.visible = false

func set_all_buttons_size(new_size:Vector2) -> void:
	for child in get_children():
		if child is SoundboardButton:
			child.initial_custom_minimum_size = new_size

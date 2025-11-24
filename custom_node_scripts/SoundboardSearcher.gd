class_name SoundboardSearcher
extends LineEdit

@export_group("Referenced Nodes")
@export var content_switcher:ContentSwitcherContainer
@export var tag_container:TagContainer

func _ready() -> void:
	text_changed.connect(_on_text_changed)
	content_switcher.content_switched.connect(_on_content_switched)
	tag_container.tag_added.connect(_on_tag_container_tag_added)
	tag_container.tag_removed.connect(_on_tag_container_tag_removed)

func get_soundboard() -> Soundboard:
	var node:Node = content_switcher.get_selected_node()
	if node is Soundboard: return node
	return null

func search(query:String, string_array:Array[String]) -> Array[String]:
	var result:Array[String] = []
	for string in string_array:
		if string.begins_with(query): result.append(string); continue
		if string.ends_with(query): result.append(string); continue
		if string.containsn(query): result.append(string); continue
	return result

func tag_filter(tags:Array[String], ids:Array[String]) -> Array[String]:
	if tags.is_empty(): return ids
	var result:Array[String] = []
	var soundboard:Soundboard = get_soundboard()
	if !soundboard: return result
	for id in ids:
		for button_tag in soundboard.get_button_tags(id):
			if button_tag in tags: result.append(id); continue
	return result

func _on_text_changed(new_text:String) -> void:
	await get_tree().physics_frame
	var soundboard = get_soundboard()
	if !soundboard: return
	if new_text == "" and tag_container.get_all_tags().is_empty(): soundboard.set_all_buttons_visible(); return
	var tag_filtered_id:Array = tag_filter(tag_container.get_all_tags(), soundboard.get_all_button_id())
	var search_result:Array[String] = search(new_text, tag_filtered_id)
	soundboard.set_all_buttons_invisible()
	for id in search_result:
		soundboard.set_button_visible(id)

func _on_content_switched(_new_node:Node) -> void:
	_on_text_changed(text)

func _on_tag_container_tag_added(_node:String) -> void:
	_on_text_changed(text)

func _on_tag_container_tag_removed(_node:String) -> void:
	_on_text_changed(text)

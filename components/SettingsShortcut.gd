class_name SettingsShortcut
extends VBoxContainer

@export_group("Referenced Nodes")
@export var new_categ:IdButton
@export var prev_categ:IdButton
@export var next_categ:IdButton
@export var search:IdButton
@export var new_tag_search:IdButton
@export var focus_sound:IdButton
@export var increase_size:IdButton
@export var decrease_size:IdButton

func _ready() -> void:
	new_categ.pressed_id.connect(_on_pressed_id)
	prev_categ.pressed_id.connect(_on_pressed_id)
	next_categ.pressed_id.connect(_on_pressed_id)
	search.pressed_id.connect(_on_pressed_id)
	new_tag_search.pressed_id.connect(_on_pressed_id)
	focus_sound.pressed_id.connect(_on_pressed_id)
	increase_size.pressed_id.connect(_on_pressed_id)
	decrease_size.pressed_id.connect(_on_pressed_id)

func _on_pressed_id(id:String):
	InputRecorder.reveal_dialog()
	var event:InputEventKey = await InputRecorder.request_input_key()
	InputRecorder.hide_dialog()
	var keycode = event.physical_keycode
	var key_text:String = OS.get_keycode_string(keycode)
	match id:
		"new_categ": 
			AppMemory.set_shortcuts_new_category(keycode)
			InputMap.action_erase_events("new_category")
			InputMap.action_add_event("new_category", event)
			new_categ.text = key_text
		"prev_categ": 
			AppMemory.set_shortcuts_previous_category(keycode)
			InputMap.action_erase_events("prev_category")
			InputMap.action_add_event("prev_category", event)
			prev_categ.text = key_text
		"next_categ": 
			AppMemory.set_shortcuts_next_category(keycode)
			InputMap.action_erase_events("next_category")
			InputMap.action_add_event("next_category", event)
			next_categ.text = key_text
		"search": 
			AppMemory.set_shortcuts_search(keycode)
			InputMap.action_erase_events("focus_search")
			InputMap.action_add_event("focus_search", event)
			search.text = key_text
		"new_tag_search": 
			AppMemory.set_shortcuts_search_tag(keycode)
			InputMap.action_erase_events("new_search_tag")
			InputMap.action_add_event("new_search_tag", event)
			new_tag_search.text = key_text
		"focus_sound": 
			AppMemory.set_shortcuts_focus_sound_button(keycode)
			InputMap.action_erase_events("focus_sound_button")
			InputMap.action_add_event("focus_sound_button", event)
			focus_sound.text = key_text
		"increase_size": 
			AppMemory.set_shortcuts_increase_sound_button(keycode)
			InputMap.action_erase_events("increase_sound_button_size")
			InputMap.action_add_event("increase_sound_button_size", event)
			increase_size.text = key_text
		"decrease_size": 
			AppMemory.set_shortcuts_decrease_sound_button(keycode)
			InputMap.action_erase_events("decrease_sound_button_size")
			InputMap.action_add_event("decrease_sound_button_size", event)
			decrease_size.text = key_text
	Saver.save_settings_data()

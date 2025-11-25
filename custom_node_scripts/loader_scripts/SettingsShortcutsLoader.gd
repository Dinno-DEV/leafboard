class_name SettingsShortcutsLoader
extends Node

@export_group("Referenced Nodes")
@export var new_categ:IdButton
@export var prev_categ:IdButton
@export var next_categ:IdButton
@export var search:IdButton
@export var new_tag_search:IdButton
@export var focus_sound:IdButton
@export var increase_size:IdButton
@export var decrease_size:IdButton

func _input(_event: InputEvent) -> void:
	if _event is not InputEventKey: return
	if Input.is_action_just_pressed("decrease_sound_button_size"): print("decrease_sound_button_size")
	if Input.is_action_just_pressed("focus_search"): print("focus_search")
	if Input.is_action_just_pressed("focus_sound_button"): print("focus_sound_button")
	if Input.is_action_just_pressed("increase_sound_button_size"): print("increase_sound_button_size")
	if Input.is_action_just_pressed("new_category"): print("new_category")
	if Input.is_action_just_pressed("new_search_tag"): print("new_search_tag")
	if Input.is_action_just_pressed("next_category"): print("next_category")
	if Input.is_action_just_pressed("prev_category"): print("prev_category")

func _ready() -> void:
	var eventkey:InputEventKey = InputEventKey.new()
	eventkey.physical_keycode = AppMemory.get_shortcuts_new_category() as Key
	new_categ.text = OS.get_keycode_string(AppMemory.get_shortcuts_new_category())
	InputMap.action_add_event("new_category", eventkey)
	
	eventkey = InputEventKey.new()
	eventkey.physical_keycode = AppMemory.get_shortcuts_previous_category() as Key
	prev_categ.text = OS.get_keycode_string(AppMemory.get_shortcuts_previous_category())
	InputMap.action_add_event("prev_category", eventkey)
	
	eventkey = InputEventKey.new()
	eventkey.physical_keycode = AppMemory.get_shortcuts_next_category() as Key
	next_categ.text = OS.get_keycode_string(AppMemory.get_shortcuts_next_category())
	InputMap.action_add_event("next_category", eventkey)
	
	eventkey = InputEventKey.new()
	eventkey.physical_keycode = AppMemory.get_shortcuts_search() as Key
	search.text = OS.get_keycode_string(AppMemory.get_shortcuts_search())
	InputMap.action_add_event("focus_search", eventkey)
	
	eventkey = InputEventKey.new()
	eventkey.physical_keycode = AppMemory.get_shortcuts_search_tag() as Key
	new_tag_search.text = OS.get_keycode_string(AppMemory.get_shortcuts_search_tag())
	InputMap.action_add_event("new_search_tag", eventkey)
	
	eventkey = InputEventKey.new()
	eventkey.physical_keycode = AppMemory.get_shortcuts_focus_sound_button() as Key
	focus_sound.text = OS.get_keycode_string(AppMemory.get_shortcuts_focus_sound_button())
	InputMap.action_add_event("focus_sound_button", eventkey)
	
	eventkey = InputEventKey.new()
	eventkey.physical_keycode = AppMemory.get_shortcuts_increase_sound_button_size() as Key
	increase_size.text = OS.get_keycode_string(AppMemory.get_shortcuts_increase_sound_button_size())
	InputMap.action_add_event("increase_sound_button_size", eventkey)
	
	eventkey = InputEventKey.new()
	eventkey.physical_keycode = AppMemory.get_shortcuts_decrease_sound_button_size() as Key
	decrease_size.text = OS.get_keycode_string(AppMemory.get_shortcuts_decrease_sound_button_size())
	InputMap.action_add_event("decrease_sound_button_size", eventkey)

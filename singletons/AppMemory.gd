extends Node

var default_data:Dictionary = {
	"soundboards": {
		#	"soundboard_name" : [
		#		{button_name, audio_path, volume, tags},
		#		{button_name, audio_path, volume, tags},
		#		{button_name, audio_path, volume, tags},
		#	],
		#	"soundboard_name_2" : [
		#		{button_name, audio_path, volume, tags},
		#		{button_name, audio_path, volume, tags},
		#	],
	},
	"soundboards_order" : [],
	"settings": {
		"general" : {
			"theme" : "theme_name",
			"audio_output" : "output_name",
			"master_volume" : 100,
		},
		"audio_button": {
			"default_volume" : 50,
			"default_name" : "Audio",
			"default_tag" : [],
		},
		"shortcuts" : {
			"new_category" : "key",
			"previous_category" : "key",
			"next_category" : "key",
			"search" : "key",
			"search_tag" : "key"
		}
	},
	"client" : {
		"previous_selected_category" : 0,
	}
}

var app_data:Dictionary = default_data.duplicate(true)

func get_app_data() -> Dictionary: return app_data.duplicate(true)

func get_soundboards_order() -> Array: return get_app_data().soundboards_order

func get_soundboards() -> Dictionary: return app_data.duplicate(true)["soundboards"]

func get_soundboard(soundboard_name:String) -> Array:
	if soundboard_name in get_soundboards().keys():
		return get_soundboards()[soundboard_name]
	return []

func get_audio_data(soundboard_name, index) -> Dictionary:
	var soundboard:Array = get_soundboard(soundboard_name)
	if index > soundboard.size()-1: return {}
	if index < 0: return {}
	return soundboard[index]

func get_settings() -> Dictionary: return app_data.duplicate(true)["settings"]
func get_general_settings() -> Dictionary: return get_settings()["general"]
func get_audio_button_settings() -> Dictionary: return get_settings()["audio_button"]
func get_shortcuts_settings() -> Dictionary: return get_settings()["shortcuts"]

func get_client() -> Dictionary: return app_data.duplicate(true)["client"]
func get_previous_selected_categ() -> int: return get_client()["previous_selected_category"]

func get_general_theme() -> String: return get_general_settings().theme
func get_general_audio_output() -> String: return get_general_settings().audio_output 
func get_general_master_volume() -> float: return get_general_settings().master_volume 

func get_audio_button_default_volume() -> float: return get_audio_button_settings().default_volume
func get_audio_button_default_name() -> String: return get_audio_button_settings().default_name
func get_audio_button_default_tag() -> Array: return get_audio_button_settings().default_tag

func get_shortcuts_new_category() -> String: return get_shortcuts_settings().new_category
func get_shortcuts_previous_category() -> String: return get_shortcuts_settings().previous_category
func get_shortcuts_next_category() -> String: return get_shortcuts_settings().next_category
func get_shortcuts_search() -> String: return get_shortcuts_settings().search
func get_shortcuts_search_tag() -> String: return get_shortcuts_settings().search_tag

func set_soundboards(data:Dictionary) -> void: 
	if data == {}: return
	app_data.soundboards = data

func set_soundboards_order(data:Array) -> void: 
	if data == []: return
	app_data.soundboards_order = data

func set_settings(data:Dictionary) -> void:
	if data == {}: return
	app_data.settings = data

func set_client(data:Dictionary) -> void:
	if data == {}: return
	app_data.client = data

func set_soundboard(soundboard_name:String, soundboard_content:Array[Dictionary]) -> void:
	app_data["soundboards"][soundboard_name] = soundboard_content
	if !app_data["soundboards_order"].has(soundboard_name):
		app_data["soundboards_order"].append(soundboard_name)

func set_soundboard_name(previous_name:String, new_name:String) -> void:
	app_data["soundboards"][new_name] = app_data["soundboards"][previous_name]
	app_data["soundboards"].erase(previous_name)
	var index:int = app_data["soundboards_order"].find(previous_name)
	app_data["soundboards_order"][index] = new_name

func set_audio_button(soundboard_name:String, new_audio_data:Dictionary, index:int) -> void:
	if app_data["soundboards"][soundboard_name].size() -1 >= index:
		app_data["soundboards"][soundboard_name][index] = new_audio_data; return
	app_data["soundboards"][soundboard_name].insert(index, new_audio_data)

func set_previous_selected_categ(selected_name:String) -> void:
	app_data["client"]["previous_selected_category"] = selected_name

func set_general_theme(theme_name:String) -> void: app_data.settings.general.theme = theme_name
func set_general_audio_output(output_name:String) -> void: app_data.settings.general.audio_output = output_name
func set_general_master_volume(master_volume:float) -> void: app_data.settings.general.master_volume = master_volume

func set_audio_button_default_volume(default_volume:float) -> void: app_data.settings.audio_button.default_volume = default_volume
func set_audio_button_default_name(default_name:String) -> void: app_data.settings.audio_button.default_name = default_name
func set_audio_button_default_tag(default_tag:Array) -> void: app_data.settings.audio_button.default_tag = default_tag

func set_shortcuts_new_category(new_key:String) -> void: app_data.settings.shortcuts.new_category = new_key
func set_shortcuts_previous_category(new_key:String) -> void: app_data.settings.shortcuts.previous_category = new_key
func set_shortcuts_next_category(new_key:String) -> void: app_data.settings.shortcuts.next_category = new_key
func set_shortcuts_search(new_key:String) -> void: app_data.settings.shortcuts.search = new_key
func set_shortcuts_search_tag(new_key:String) -> void: app_data.settings.shortcuts.search_tag = new_key

func delete_soundboard(soundboard_name:String) -> void:
	app_data["soundboards"].erase(soundboard_name)
	app_data["soundboards_order"].erase(soundboard_name)

func delete_audio_button(soundboard_name:String, index:int) -> void:
	app_data["soundboards"][soundboard_name].remove_at(index)

func move_audio_button(soundboard_name:String, previous_index:int, target_index:int) -> void:
	var moving_audio_button:Dictionary = app_data["soundboards"][soundboard_name].pop_at(previous_index)
	app_data["soundboards"][soundboard_name].insert(target_index, moving_audio_button)

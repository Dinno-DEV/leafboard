extends Node

signal soundboards_loaded(data:Dictionary)
signal soundboards_order_loaded(data:Array)
signal settings_loaded(data:Dictionary)
signal client_loaded(data:Dictionary)

func _ready() -> void:
	AppMemory.set_soundboards(load_soundboards_data())
	AppMemory.set_soundboards_order(load_soundboards_order())
	AppMemory.set_settings(load_settings_data())
	AppMemory.set_client(load_client_data())

func load_soundboards_data() -> Dictionary:
	var path:String = FileUtil.get_directory_path(FileUtil.SOUNDBOARD) + "soundboards.json"
	if !FileAccess.file_exists(path): return {}
	var file:FileAccess = FileAccess.open(path, FileAccess.READ)
	soundboards_loaded.emit(JSON.parse_string(file.get_as_text()))
	return JSON.parse_string(file.get_as_text())

func load_soundboards_order() -> Array:
	var path:String = FileUtil.get_directory_path(FileUtil.SOUNDBOARD) + "soundboards_order.json"
	if !FileAccess.file_exists(path): return []
	var file:FileAccess = FileAccess.open(path, FileAccess.READ)
	soundboards_order_loaded.emit(JSON.parse_string(file.get_as_text()))
	return JSON.parse_string(file.get_as_text())

func load_settings_data() -> Dictionary:
	var path:String = FileUtil.get_directory_path(FileUtil.SETTINGS) + "settings.json"
	if !FileAccess.file_exists(path): return {}
	var file:FileAccess = FileAccess.open(path, FileAccess.READ)
	settings_loaded.emit(JSON.parse_string(file.get_as_text()))
	return JSON.parse_string(file.get_as_text())

func load_client_data() -> Dictionary:
	var path:String = FileUtil.get_directory_path(FileUtil.SETTINGS) + "client.json"
	if !FileAccess.file_exists(path): return {}
	var file:FileAccess = FileAccess.open(path, FileAccess.READ)
	client_loaded.emit(JSON.parse_string(file.get_as_text()))
	return JSON.parse_string(file.get_as_text())

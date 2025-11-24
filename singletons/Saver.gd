extends Node

func save_all() -> void:
	save_soundboards_data()
	save_settings_data()
	save_clients_data()

func save_soundboards_data() -> void:
	FileUtil.create_soundboard_folder()
	var file:FileAccess = FileAccess.open(FileUtil.get_directory_path(FileUtil.SOUNDBOARD) + "soundboards.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(AppMemory.get_soundboards()))
	file.close()
	file = FileAccess.open(FileUtil.get_directory_path(FileUtil.SOUNDBOARD) + "soundboards_order.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(AppMemory.get_soundboards_order()))
	file.close()

func save_settings_data() -> void:
	FileUtil.create_settings_folder()
	var file:FileAccess = FileAccess.open(FileUtil.get_directory_path(FileUtil.SETTINGS) + "settings.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(AppMemory.get_settings()))
	file.close()

func save_clients_data() -> void:
	FileUtil.create_settings_folder()
	var file:FileAccess = FileAccess.open(FileUtil.get_directory_path(FileUtil.SETTINGS) + "client.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(AppMemory.get_client()) + "")
	file.close()

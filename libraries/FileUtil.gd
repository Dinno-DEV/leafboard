class_name FileUtil
extends Node

enum {
	AUDIO, SOUNDBOARD, SETTINGS
}

static func is_file_name_audio_index(file_name:String) -> bool:
	if file_name.split(".").size() > 2: return false
	return remove_extension(file_name).is_valid_int()

static func is_file_extension(extension:String, file_path:String) -> bool:
	return file_path.ends_with(extension)

static func is_file_name_exist(file_name:String, directory:int = AUDIO) -> bool:
	return DirAccess.open(get_directory_path(directory)).file_exists(file_name)

static func is_audio_data_exists(audio_stream:AudioStreamMP3) -> bool:
	for file_name in DirAccess.open(get_directory_path(AUDIO)).get_files():
		if load_file_as_mp3(get_directory_path(AUDIO) + file_name).data == audio_stream.data: return true
	return false

static func get_audio_path_that_exists(audio_stream:AudioStream) -> String:
	for file_name in DirAccess.open(get_directory_path(AUDIO)).get_files():
		var current_path_to_check:String = get_directory_path(AUDIO) + file_name
		if is_file_extension(".mp3", file_name):
			if load_file_as_mp3(current_path_to_check).data == audio_stream.data: return current_path_to_check
		if is_file_extension(".wav", file_name):
			if load_file_as_wav(current_path_to_check).data == audio_stream.data: return current_path_to_check
	return ""

static func get_filtered_file_extension(extension:String, file_paths:Array[String]) -> Array[String]:
	var result:Array[String] = []
	for file_path in file_paths:
		if is_file_extension(extension,file_path): result.append(file_path)
	return result

static func get_file_name_from_path(path:String) -> String:
	if !path.is_absolute_path(): return ""
	var split_path:PackedStringArray = path.split("\\")
	return split_path[split_path.size()-1]

static func get_last_audio_index() -> int:
	var file_names:PackedStringArray = DirAccess.open(get_directory_path(AUDIO)).get_files()
	var cursor:int = file_names.size() - 1
	if cursor == -1: return 0
	var file_name:String = file_names[cursor]
	while !is_file_name_audio_index(file_name):
		if cursor == 0: return 0
		cursor -= 1
		file_name = file_names[cursor]
	return int(remove_extension(file_names[cursor]))

static func clean_file_path(file_path:String) -> String:
	return "/".join(file_path.split("\\\\"))

static func remove_extension(file_name:String) -> String:
	return file_name.split(".")[0]

static func load_file_as_mp3(file_path:String) -> AudioStreamMP3:
	if !file_path.is_absolute_path(): return
	if !is_file_extension(".mp3", file_path): return
	var file:FileAccess = FileAccess.open(file_path, FileAccess.READ)
	var sound:AudioStreamMP3 = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	file.close()
	return sound

static func load_file_as_wav(file_path:String) -> AudioStreamWAV:
	if !file_path.is_absolute_path(): return
	if !is_file_extension(".wav", file_path): return
	var sound:AudioStreamWAV = AudioStreamWAV.new()
	sound.data = FileAccess.get_file_as_bytes(file_path)
	return sound

static func create_settings_folder() -> void:
	DirAccess.make_dir_absolute(get_directory_path(SETTINGS))

static func create_soundboard_folder() -> void:
	DirAccess.make_dir_absolute(get_directory_path(SOUNDBOARD))

static func create_audio_folder() -> void:
	DirAccess.make_dir_absolute(get_directory_path(AUDIO))

static func get_directory_path(directory:int) -> String:
	match directory:
		AUDIO: return "user://audios/"
		SOUNDBOARD: return "user://soundboards/"
		SETTINGS: return "user://settings/"
	return ""

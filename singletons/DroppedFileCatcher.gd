extends CanvasLayer

signal files_dropped(file_paths:Array[String])

func _ready() -> void:
	get_window().files_dropped.connect(_on_files_dropped)

func _on_files_dropped(files:PackedStringArray) -> void:
	# filter so it only takes audio files
	var paths:Array[String] = FileUtil.get_filtered_file_extension(".mp3", files) + FileUtil.get_filtered_file_extension(".wav", files)
	if paths.is_empty(): return
	# user_directories used for signalling later
	var directories_to_signal:Array[String] = []
	FileUtil.create_audio_folder()
	for path in paths:
		var extension:String = ".mp3"
		# if it finds existing ones, add the existing path to the user_directories
		var existing_audio_path:String = ""
		if FileUtil.is_file_extension(".mp3", path):
			existing_audio_path = FileUtil.get_audio_path_that_exists(FileUtil.load_file_as_mp3(path))
		elif FileUtil.is_file_extension(".wav", path):
			extension = ".wav"
			existing_audio_path = FileUtil.get_audio_path_that_exists(FileUtil.load_file_as_wav(path))
		if !existing_audio_path.is_empty(): directories_to_signal.append(existing_audio_path); continue
		# if it doesn't, make new one, add that directory to the user_directories
		var new_audio_file_name:String = FileUtil.get_directory_path(FileUtil.AUDIO) + str(FileUtil.get_last_audio_index() + 1) + extension
		DirAccess.copy_absolute(path, new_audio_file_name)
		directories_to_signal.append(new_audio_file_name)
	files_dropped.emit(directories_to_signal)

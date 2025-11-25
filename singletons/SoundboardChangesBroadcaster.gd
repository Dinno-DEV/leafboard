extends Node

@export_group("Referenced Nodes")
@export var audio_preview_player:AudioStreamPlayer
@export var timer:Timer

var is_preview_playing:bool = false

signal audio_button_data_broadcasted(audio_name:String, audio_path:String)
signal audio_button_added(soundboard_name:String,audio_button:SoundboardButton)

func _ready() -> void:
	DroppedFileCatcher.files_dropped.connect(_on_dropped_file_catcher_files_dropped)
	audio_preview_player.finished.connect(_on_audio_preview_player_finished)
	timer.timeout.connect(_on_timer_timeout)

func _on_dropped_file_catcher_files_dropped(file_paths:Array[String]):
	DialogTextInput.reveal_dialogs()
	for file_path in file_paths:
		start_playing_preview(file_path)
		var response = await DialogTextInput.request_response("Sound name")
		stop_playing_preview()
		var audio_name = response[0]
		if audio_name.is_empty(): audio_name = AppMemory.get_audio_button_default_name() + FileUtil.remove_extension(FileUtil.get_file_name_from_path(file_path))
		if response[1]: audio_button_data_broadcasted.emit(audio_name, file_path)
	DialogTextInput.hide_dialogs()

func start_playing_preview(audio_path:String):
	audio_preview_player.stream = FileUtil.load_file_as_mp3(audio_path)
	audio_preview_player.play()
	is_preview_playing = true

func stop_playing_preview():
	audio_preview_player.stop()
	timer.stop()
	is_preview_playing = false

func announce_button_added(soundboard_name:String, button:SoundboardButton) -> void:
	audio_button_added.emit(soundboard_name, button)

func _on_timer_timeout():
	if is_preview_playing: audio_preview_player.play()

func _on_audio_preview_player_finished():
	if is_preview_playing: timer.start()

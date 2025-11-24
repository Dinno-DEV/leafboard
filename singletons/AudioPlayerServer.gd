extends Node

func play_audio(path:String) -> AudioStreamPlayer:
	var audio_player:AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(audio_player)
	if FileUtil.is_file_extension(".mp3", path):
		audio_player.stream = FileUtil.load_file_as_mp3(path)
	if FileUtil.is_file_extension(".wav", path):
		audio_player.stream = FileUtil.load_file_as_wav(path)
	audio_player.play()
	delete_after_finish(audio_player)
	return audio_player

func delete_after_finish(audio_player:AudioStreamPlayer) -> void:
	await audio_player.finished
	audio_player.queue_free()

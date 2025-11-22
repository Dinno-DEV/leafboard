class_name SoundboardButtonSpawner
extends Node

@export_group("Referenced Nodes")
@export var content_switcher_container:ContentSwitcherContainer

func _ready() -> void:
	SoundboardChangesBroadcaster.audio_button_data_broadcasted.connect(_on_audio_button_data_broadcasted)

func get_soundboard() -> Soundboard:
	var node:Node = content_switcher_container.get_selected_node()
	if node is Soundboard: return node
	return null

func _on_audio_button_data_broadcasted(audio_name:String, audio_path:String):
	var soundboard:Soundboard = get_soundboard()
	if !soundboard: return
	soundboard.add_new_button(audio_name, audio_path)

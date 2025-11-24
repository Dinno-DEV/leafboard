class_name SoundboardLoader
extends Node

@export_group("Referenced Nodes")
@export var category_spawner:CategorySpawner

var soundboards_data:Dictionary
var soundboards_order:Array

func _ready() -> void:
	soundboards_data = Loader.load_soundboards_data()
	soundboards_order = Loader.load_soundboards_order()
	load_soundboards()

func load_soundboards() -> void:
	for soundboard_name in soundboards_order:
		category_spawner.spawn_category_button(soundboard_name)
		var soundboard:Soundboard = category_spawner.spawn_soundboard(soundboard_name)
		for audio_data in soundboards_data[soundboard_name]:
			soundboard.add_new_button(
				audio_data["button_name"],
				audio_data["audio_path"],
				audio_data["volume"],
				audio_data["tags"],
			)

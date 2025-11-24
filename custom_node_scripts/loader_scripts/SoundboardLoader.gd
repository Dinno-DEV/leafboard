class_name SoundboardLoader
extends Node

@export_group("Referenced Nodes")
@export var category_spawner:CategorySpawner
@export var selector:Selector

var soundboards_data:Dictionary
var soundboards_order:Array
var prev_selected:String

func _ready() -> void:
	soundboards_data = AppMemory.get_soundboards()
	soundboards_order = AppMemory.get_soundboards_order()
	prev_selected = AppMemory.get_previous_selected_categ()
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
	selector.select(prev_selected)
	selector.selected.emit(prev_selected)

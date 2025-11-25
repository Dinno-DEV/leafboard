class_name SettingsGeneralLoader
extends Node

@export_group("Referenced Nodes")
@export var master_volume_slider:HSlider
@export var audio_output_options:OptionButton

func _ready() -> void:
	for names in AudioServer.get_output_device_list():
		audio_output_options.add_item(names)
	master_volume_slider.value = AppMemory.get_general_master_volume()
	for index in range(audio_output_options.item_count):
		if audio_output_options.get_item_text(index) == AppMemory.get_general_audio_output():
			audio_output_options.select(index); return

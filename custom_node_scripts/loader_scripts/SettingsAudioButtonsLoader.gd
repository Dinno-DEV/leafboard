class_name SettingsAudioButtonsLoader
extends Node

@export_group("Referenced Nodes")
@export var default_volume_slider:HSlider
@export var default_name_line_edit:LineEdit
@export var default_tag_container:TagContainer

func _ready() -> void:
	default_volume_slider.value = AppMemory.get_audio_button_default_volume()
	default_name_line_edit.text = AppMemory.get_audio_button_default_name()
	for tag in AppMemory.get_audio_button_default_tag():
		var tag_button:TagButton = TagButton.new()
		default_tag_container.add_child(tag_button)
		tag_button.set_tag_name(tag)

class_name SettingsAudioButtons
extends VBoxContainer

@export_group("Referenced Nodes")
@export var default_volume_slider:HSlider
@export var default_name_line_edit:LineEdit
@export var default_tag_container:TagContainer

func _ready() -> void:
	default_volume_slider.value_changed.connect(_on_value_changed)
	default_name_line_edit.text_changed.connect(_on_text_changed)
	default_tag_container.tag_added.connect(_on_tags_edited)
	default_tag_container.tag_removed.connect(_on_tags_edited)

func _on_value_changed(new_value:float) -> void:
	AppMemory.set_audio_button_default_volume(new_value)
	Saver.save_settings_data()

func _on_text_changed(new_text:String) -> void:
	AppMemory.set_audio_button_default_name(new_text)
	Saver.save_settings_data()

func _on_tags_edited(_new_tag:String) -> void:
	await get_tree().create_timer(0.1).timeout
	AppMemory.set_audio_button_default_tag(default_tag_container.get_all_tags())
	Saver.save_settings_data()

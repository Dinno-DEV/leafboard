class_name SettingsGeneralDataCollector
extends Node

func _ready() -> void:
	var parent:Node = get_parent()
	if parent is SettingsGeneral:
		parent.master_volume_changed.connect(_on_master_volume_changed)
		parent.output_device_changed.connect(_on_output_device_changed)

func _on_master_volume_changed(new_value:float) -> void:
	AppMemory.set_general_master_volume(new_value)
	Saver.save_settings_data()

func _on_output_device_changed(device:String) -> void:
	AppMemory.set_general_audio_output(device)
	Saver.save_settings_data()

class_name SettingsGeneral
extends VBoxContainer

@export_group("Referenced Nodes")
@export var master_volume_slider:HSlider
@export var audio_output_options:OptionButton

signal master_volume_changed(new_volume:float)
signal output_device_changed(device:String)

func _ready() -> void:
	master_volume_slider.value_changed.connect(_on_master_volume_value_changed)
	audio_output_options.item_selected.connect(_on_audio_options_item_selected)

func _on_master_volume_value_changed(new_value:float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(new_value/100))
	master_volume_changed.emit(new_value)

func _on_audio_options_item_selected(index:int) -> void:
	var device:String = audio_output_options.get_item_text(index)
	AudioServer.output_device = device
	output_device_changed.emit(device)

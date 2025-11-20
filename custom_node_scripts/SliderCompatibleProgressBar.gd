class_name SliderCompatibleProgressBar
extends ProgressBar

@export_group("Referenced Nodes")
@export var slider:Slider

func _ready() -> void:
	if !slider: return
	connect_slider_to_bar(slider)

func connect_slider_to_bar(new_slider:Slider):
	new_slider.value_changed.connect(_on_slider_value_changed)

func _on_slider_value_changed(new_value:float) -> void:
	value = new_value

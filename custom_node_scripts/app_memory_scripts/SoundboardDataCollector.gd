class_name SoundboardDataCollector
extends Node

@export_group("Referenced Nodes")
@export var content_switcher:ContentSwitcherContainer

func _ready() -> void:
	content_switcher.content_switched.connect(_on_content_switched)

func _on_content_switched(selected_node:Node) -> void:
	if selected_node is not Soundboard: return
	selected_node.button_added.connect(_on_soundboard_button_added)
	AppMemory.set_previous_selected_categ(selected_node.get_soundboard_name())

func _on_soundboard_button_added(new_button:SoundboardButton) -> void:
	AppMemory.set_audio_button(
		NodeUtil.get_soundboard_from_csc(content_switcher).get_soundboard_name(),
		new_button.get_button_data(),
		new_button.get_index()
	)

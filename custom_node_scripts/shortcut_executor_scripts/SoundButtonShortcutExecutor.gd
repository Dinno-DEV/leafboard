class_name SoundButtonShortcutExecutor
extends Node

@export_group("Referenced Nodes")
@export var search:SoundboardSearcher
@export var content_switcher:ContentSwitcherContainer
@export var button_resizer:SoundboardButtonResizer

func _ready():
	search.text_submitted.connect(_on_text_submitted)

func _shortcut_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("focus_sound_button"):
		select_first_node_on_enter()
	if Input.is_action_just_pressed("increase_sound_button_size"):
		button_resizer._on_zoom_in_button_pressed()
	if Input.is_action_just_pressed("decrease_sound_button_size"):
		button_resizer._on_zoom_out_button_pressed()

func select_first_node_on_enter() -> void:
		var node:Node = content_switcher.get_selected_node()
		if node is Soundboard:
			var first_child:Node
			for child in node.get_children():
				if child.visible: first_child = child; break
			if first_child:
				if first_child is SoundboardButton:
					first_child.play_button.grab_click_focus()
					first_child.play_button.grab_focus()

func _on_text_submitted(_new_text:String) -> void:
	select_first_node_on_enter()

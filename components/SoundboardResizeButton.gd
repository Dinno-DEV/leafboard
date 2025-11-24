class_name SoundboardButtonResizer
extends PanelContainer

@export var initial_size:float = 150
@export var increment:float = 50
@export var min_size:float = 150
@export var max_size:float = 350
@export_group("Referenced Nodes")
@export var content_switcher:ContentSwitcherContainer
@export var size_indicator:Label

@onready var current_size:float = initial_size

func _ready() -> void:
	content_switcher.content_shown.connect(_on_content_shown)

func get_soundboard() -> Soundboard:
	if content_switcher.get_selected_node() is Soundboard:
		return content_switcher.get_selected_node()
	else: return null

func set_increment(new_value:float) -> void:
	increment = new_value

func set_size_indicator(new_text:String) -> void:
	size_indicator.text = new_text

func _on_zoom_in_button_pressed() -> void:
	var soundboard:Soundboard = get_soundboard()
	if !soundboard: return
	if current_size + increment > max_size: return
	current_size += increment
	soundboard.set_all_buttons_size(Vector2(current_size,current_size))
	set_size_indicator(str(int(current_size)))

func _on_zoom_out_button_pressed() -> void:
	var soundboard:Soundboard = get_soundboard()
	if !soundboard: return
	if current_size - increment < min_size: return
	current_size -= increment
	soundboard.set_all_buttons_size(Vector2(current_size,current_size))
	set_size_indicator(str(int(current_size)))

func _on_content_shown(node:Node) -> void:
	var soundboard:Soundboard = node
	if !soundboard: return
	soundboard.set_all_buttons_size(Vector2(current_size,current_size))

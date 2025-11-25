extends CanvasLayer

@export_group("Referenced Nodes")
@export var animation_player:AnimationPlayer

var is_recording:bool = false

signal input_received(event:InputEvent)

func _input(event: InputEvent) -> void:
	if !is_recording: return
	if event is not InputEventKey: return
	var keycode:String = OS.get_keycode_string(event.get_keycode_with_modifiers())
	if keycode.containsn("ctrl"): return
	elif keycode.containsn("shift"): return
	elif keycode.containsn("alt"): return
	input_received.emit(event)
	get_viewport().set_input_as_handled()

func request_input_key() -> InputEvent:
	is_recording = true
	var input = await input_received
	is_recording = false
	return input

func reveal_dialog() -> void:
	visible = true
	animation_player.play("fade_in")

func hide_dialog() -> void:
	animation_player.play("fade_out")
	await animation_player.animation_finished
	visible = false

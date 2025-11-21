extends CanvasLayer

@export_group("Referenced Nodes")
@export var dialog_container:Panel
@export var animation_player:AnimationPlayer

signal response_received(response:String, is_confirmed:bool)

func _ready() -> void:
	response_received.connect(_on_response_received)

func request_response(message:String, max_letter:int = -1) -> Array:
	var text_input_panel:DialogTextInputPanel = preload("res://components/DialogTextInputPanel.tscn").instantiate()
	text_input_panel.place_holder_text = message
	if max_letter > -1:
		text_input_panel.line_edit.max_length = max_letter
	dialog_container.add_child(text_input_panel)
	var response = await text_input_panel.response_received
	text_input_panel.queue_free()
	await text_input_panel.tree_exited
	response_received.emit(response[0], response[1])
	return response

func is_empty() -> bool:
	return dialog_container.get_child_count() == 0

func focus_first_dialog() -> void:
	# unsee all child and see first DialogConfirmPanel child
	for child in dialog_container.get_children():
		if child is CanvasItem: child.visible = false
	for child in dialog_container.get_children():
		if NodeUtil.get_type_as_string(child) == "DialogTextInputPanel":
			child.visible = true

func reveal_dialogs() -> void:
	visible = true
	animation_player.play("fade_in")
	await animation_player.animation_finished

func hide_dialogs() -> void:
	animation_player.play("fade_out")
	await animation_player.animation_finished
	visible = false

func _on_response_received(_response:String, _is_confirmed:bool) -> void:
	focus_first_dialog()

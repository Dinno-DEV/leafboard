extends CanvasLayer

@export_group("Referenced Nodes")
@export var message_container:Panel
@export var animation_player:AnimationPlayer

signal response_received(response:bool)

func _ready() -> void:
	response_received.connect(_on_response_received)

func request_response(message:String) -> bool:
	# add new confirm panel
	var confirm_panel:DialogConfirmPanel = preload("res://components/DialogConfirmPanel.tscn").instantiate()
	confirm_panel.dialog_message = message
	message_container.add_child(confirm_panel)
	focus_first_dialog()
	# wait and return response
	var response:bool = await confirm_panel.received_response
	confirm_panel.queue_free()
	return response

func focus_first_dialog() -> void:
	# unsee all child and see first DialogConfirmPanel child
	for child in message_container.get_children():
		if child is CanvasItem: child.visible = false
	for child in message_container.get_children():
		if NodeUtil.get_type_as_string(child) == "DialogConfirmPanel":
			child.visible = true

func reveal_dialogs() -> void:
	animation_player.play("fade_in")
	await animation_player.animation_finished

func hide_dialogs() -> void:
	animation_player.play("fade_out")
	await animation_player.animation_finished

func _on_response_received(_response:bool) -> void:
	focus_first_dialog()

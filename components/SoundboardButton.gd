@tool
class_name SoundboardButton
extends SquarePanelContainer

const DEFAULT_BUTTON_DATA:Dictionary = {
	"button_name": "Default",
	"audio_path": "",
	"volume": 50,
	"tags": []
}

@export_group("Referenced Nodes")
@export var volume_slider:HSlider
@export var play_button:Button
@export var sound_title:Label
@export var music_icon:TextureRect
@export var play_icon:TextureRect
@export var stop_icon:TextureRect
@export var edit_button:Button
@export var move_button:Button
@export var highlighter:ProgressBar

@export var editor_container:PanelContainer
@export var name_edit:LineEdit
@export var tag_container:TagContainer
@export var delete_button:Button
@export var cancel_button:Button
@export var confirm_button:Button

@export var sound_progress_bar:ProgressBar

var button_data:Dictionary = DEFAULT_BUTTON_DATA.duplicate()
var current_audio:AudioStreamPlayer

signal button_moved(new_index:int)
signal button_edited(button_data:Dictionary)
signal button_deleted()

func _ready() -> void:
	volume_slider.value_changed.connect(_on_volume_slider_value_changed)
	play_button.mouse_entered.connect(_on_mouse_entered)
	play_button.focus_entered.connect(_on_mouse_entered)
	play_button.mouse_exited.connect(_on_mouse_exited)
	play_button.focus_exited.connect(_on_mouse_exited)
	edit_button.pressed.connect(_on_edit_button_pressed)
	delete_button.pressed.connect(_on_delete_button_pressed)
	cancel_button.pressed.connect(_on_cancel_button_pressed)
	confirm_button.pressed.connect(_on_confirm_button_pressed)
	move_button.button_up.connect(_on_move_button_up)
	move_button.button_down.connect(_on_move_button_down)

func _physics_process(_delta: float) -> void:
	if current_audio != null: sound_progress_bar.value = current_audio.get_playback_position()
	else: sound_progress_bar.value = 0

func get_button_data() -> Dictionary:
	return button_data.duplicate()

func get_button_name() -> String:
	return get_button_data()["button_name"]

func get_button_volume() -> float:
	return get_button_data()["volume"]

func get_button_tags() -> Array:
	return get_button_data()["tags"]

func is_playing() -> bool:
	if current_audio != null: return current_audio.is_playing()
	return false

func set_button_data(
	new_name:String, 
	new_audio_path:String,
	new_audio_volume:float,
	new_tags:Array
):
	set_button_name(new_name)
	set_audio(new_audio_path)
	set_volume(new_audio_volume)
	set_tags(new_tags)

func set_button_name(new_name:String) -> void:
	button_data["button_name"] = new_name
	sound_title.text = new_name

func set_audio(new_path:String) -> void:
	if new_path == "": return
	if !FileAccess.file_exists(new_path):
		DialogConfirmation.reveal_dialogs()
		await DialogConfirmation.request_response("File does not exist")
		if DialogConfirmation.is_empty(): DialogConfirmation.hide_dialogs()
		self.queue_free()
		return
	button_data["audio_path"] = new_path

func set_volume(new_volume:float) -> void:
	button_data["volume"] = new_volume
	if current_audio != null: current_audio.volume_db = linear_to_db(new_volume/100)
	volume_slider.set_value_no_signal(new_volume)
	button_edited.emit(get_button_data())

func set_tags(new_tags:Array) -> void:
	button_data["tags"] = new_tags

func set_all_icon_invisible() -> void:
	music_icon.visible = false
	play_icon.visible = false
	stop_icon.visible = false

func switch_icon_visible(icon:TextureRect) -> void:
	set_all_icon_invisible()
	icon.visible = true

func start_editing() -> void:
	name_edit.text = button_data.duplicate()["button_name"]
	var tags_reversed:Array[String] = []
	for tag in button_data["tags"]:
		tags_reversed.push_front(tag)
	for tag in tags_reversed:
		var tag_button:TagButton = TagButton.new()
		tag_button.tag_name = tag
		tag_container.add_child(tag_button)
		tag_container.move_child(tag_button,0)
	editor_container.visible = true

func cancel_editing() -> void:
	DialogConfirmation.reveal_dialogs()
	var response = await DialogConfirmation.request_response("Cancel Editing?")
	DialogConfirmation.hide_dialogs()
	if !response: return
	close_editor()

func confirm_editing() -> void:
	DialogConfirmation.reveal_dialogs()
	var response = await DialogConfirmation.request_response("Confirm Editing?")
	DialogConfirmation.hide_dialogs()
	if !response: return
	set_button_name(name_edit.text)
	set_tags(tag_container.get_all_tags())
	close_editor()
	button_edited.emit(get_button_data())

func close_editor() -> void:
	editor_container.visible = false
	name_edit.clear()
	for child in tag_container.get_children():
		if child is TagButton:
			child.queue_free()

func delete_sound_button() -> void:
	DialogConfirmation.reveal_dialogs()
	var response:bool = await DialogConfirmation.request_response("Are you sure?")
	DialogConfirmation.hide_dialogs()
	if !response: return
	button_deleted.emit()
	self.queue_free()

func _on_audio_player_finished() -> void:
	switch_icon_visible(music_icon)
	sound_progress_bar.value = 0

func _on_volume_slider_value_changed(new_value:float) -> void:
	set_volume(new_value)

func _on_play_button_pressed() -> void:
	if current_audio != null:
		current_audio.finished.emit()
		switch_icon_visible(play_icon)
		sound_progress_bar.value = 0
	else:
		current_audio = AudioPlayerServer.play_audio(button_data.audio_path)
		current_audio.volume_db = linear_to_db(get_button_volume()/100)
		sound_progress_bar.max_value = current_audio.stream.get_length()
		switch_icon_visible(stop_icon)

func _on_mouse_entered() -> void:
	if current_audio != null:
		switch_icon_visible(stop_icon)
	else:
		switch_icon_visible(play_icon)

func _on_mouse_exited() -> void:
	if current_audio != null:
		switch_icon_visible(stop_icon)
	else:
		switch_icon_visible(music_icon)

func _on_edit_button_pressed() -> void:
	start_editing()

func _on_delete_button_pressed() -> void:
	delete_sound_button()

func _on_cancel_button_pressed() -> void:
	cancel_editing()

func _on_confirm_button_pressed() -> void:
	confirm_editing()

var previous_index:int = 0

func _on_move_button_down() -> void:
	var soundboard:Node = get_parent()
	if soundboard is not Soundboard: return
	if soundboard.is_some_button_invisible(): return
	is_reordering = true
	highlighter.visible = true
	previous_index = get_index()

func _on_move_button_up() -> void:
	is_reordering = false
	highlighter.visible = false
	button_moved.emit(get_index(), previous_index)

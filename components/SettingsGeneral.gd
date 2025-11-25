class_name SettingsGeneral
extends VBoxContainer

@export_group("Referenced Nodes")
@export var master_volume_slider:HSlider
@export var audio_output_options:OptionButton
@export var delete_data:Button
@export var complete_wipe:Button

signal master_volume_changed(new_volume:float)
signal output_device_changed(device:String)

func _ready() -> void:
	master_volume_slider.value_changed.connect(_on_master_volume_value_changed)
	audio_output_options.item_selected.connect(_on_audio_options_item_selected)
	delete_data.pressed.connect(_on_delete_data_pressed)
	complete_wipe.pressed.connect(_on_complete_wipe_pressed)

func _on_master_volume_value_changed(new_value:float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(new_value/100))
	master_volume_changed.emit(new_value)

func _on_audio_options_item_selected(index:int) -> void:
	var device:String = audio_output_options.get_item_text(index)
	AudioServer.output_device = device
	output_device_changed.emit(device)

func _on_delete_data_pressed() -> void:
	DialogConfirmation.reveal_dialogs()
	var response = await DialogConfirmation.request_response("This will erase all category data. Proceed?")
	if response:
		DirAccess.remove_absolute(FileUtil.get_directory_path(FileUtil.SOUNDBOARD) + "soundboards.json")
		DirAccess.remove_absolute(FileUtil.get_directory_path(FileUtil.SOUNDBOARD) + "soundboards_order.json")
		DirAccess.remove_absolute(FileUtil.get_directory_path(FileUtil.SETTINGS) + "client.json")
	await get_tree().create_timer(0.1).timeout
	var _new_resp = await DialogConfirmation.request_response("Data deleted. Please restart.")
	DialogConfirmation.hide_dialogs()
	await get_tree().physics_frame
	get_tree().quit()

func _on_complete_wipe_pressed() -> void:
	DialogConfirmation.reveal_dialogs()
	var response = await DialogConfirmation.request_response("This will erase ALL DATA. Proceed?")
	if response:
		DirAccess.remove_absolute(FileUtil.get_directory_path(FileUtil.SOUNDBOARD) + "soundboards.json")
		DirAccess.remove_absolute(FileUtil.get_directory_path(FileUtil.SOUNDBOARD) + "soundboards_order.json")
		DirAccess.remove_absolute(FileUtil.get_directory_path(FileUtil.SETTINGS) + "client.json")
		for file in DirAccess.open(FileUtil.get_directory_path(FileUtil.AUDIO)).get_files():
			DirAccess.remove_absolute(FileUtil.get_directory_path(FileUtil.AUDIO) + file)
	await get_tree().create_timer(0.1).timeout
	var _new_resp = await DialogConfirmation.request_response("Data deleted. Please restart.")
	DialogConfirmation.hide_dialogs()
	await get_tree().physics_frame
	get_tree().quit()

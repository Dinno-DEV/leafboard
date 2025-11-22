class_name SelectorSearcher
extends LineEdit

@export_group("Referenced Nodes")
@export var selector:Selector

func _ready() -> void:
	text_changed.connect(_on_text_changed)

func get_all_id_buttons() -> Array[IdButton]:
	if !selector: return []
	var result:Array[IdButton] = []
	for child in selector.get_children():
		if child is IdButton: result.append(child)
	return result

func set_all_id_buttons_invisible(id_buttons:Array[IdButton]) -> void:
	for id_button in id_buttons:
		id_button.visible = false
	selector.visible = false

func set_all_id_buttons_visible(id_buttons:Array[IdButton]) -> void:
	for id_button in id_buttons:
		id_button.visible = true
	selector.visible = true

func set_id_button_visible(id_button:IdButton):
	id_button.visible = true
	selector.visible = true

func _on_text_changed(new_text:String) -> void:
	if new_text.is_empty(): set_all_id_buttons_visible(get_all_id_buttons()); return
	var id_buttons:Array[IdButton] = get_all_id_buttons()
	var search_result:Array[IdButton] = []
	for id_button in id_buttons:
		if id_button.button_id.begins_with(new_text): search_result.append(id_button)
		if id_button.button_id.ends_with(new_text): search_result.append(id_button)
		if id_button.button_id.containsn(new_text): search_result.append(id_button)
	set_all_id_buttons_invisible(id_buttons)
	for id_button in search_result:
		set_id_button_visible(id_button)

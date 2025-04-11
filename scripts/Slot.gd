extends PanelContainer
class_name Slot

@onready var texture_rect = $TextureRect
@export var item : Item = null: # setter variable for storing item and updating texture
	set(value):
		item = value
		
		# if parent of slot is a character node, then equip item
		if get_parent().name == "Character":
			get_parent().equip(item)
		
		if value != null:
			texture_rect.texture = value.icon
		else:
			texture_rect.texture = null

# preview for the dragged item with TextureRect
func get_preview():
	var preview_texture = TextureRect.new()
	preview_texture.texture = texture_rect.texture
	preview_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview_texture.custom_minimum_size = Vector2(20, 20)
	
	# Center preview with Control and return it
	var preview = Control.new()
	preview.add_child(preview_texture)
	preview_texture.position = -0.5 * Vector2(20, 20)
	
	return preview

func _get_drag_data(at_position):
	set_drag_preview(get_preview())
	return self

func _can_drop_data(at_position, data):
	return data is Slot

#swap items between them after dropping
func _drop_data(at_position, data):
	var temp = item
	item = data.item
	data.item = temp
	

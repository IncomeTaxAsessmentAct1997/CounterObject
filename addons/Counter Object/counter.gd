extends Node2D
class_name Counter
@export_group("Counter Settings")
@export var value: int = 0:
	set(v):
		value = clamp(v, minimum_value, maximum_value)
		_update_display()
@export var minimum_value: int = -999999
@export var maximum_value: int = 999999
@export_group("Display Settings")
@export var digit_sprite_sheet: Texture2D
@export var digit_width: int = 16
@export var digit_height: int = 16
var _digit_sprites: Array[Sprite2D] = []
func _ready():
	_update_display()
func _update_display():
	if not is_inside_tree():
		return
	
	for sprite in _digit_sprites:
		sprite.queue_free()
	_digit_sprites.clear()
	
	if digit_sprite_sheet == null:
		return
	
	var is_negative = value < 0
	var value_str = str(abs(value))
	var digit_count = len(value_str)
	
	if is_negative:
		digit_count += 1
	
	var x_pos = -digit_count * digit_width
	
	if is_negative:
		var minus_sprite = _create_digit_sprite(10)
		minus_sprite.position.x = x_pos
		minus_sprite.position.y = -digit_height
		add_child(minus_sprite)
		_digit_sprites.append(minus_sprite)
		x_pos += digit_width
	
	for i in range(len(value_str)):
		var digit_sprite = _create_digit_sprite(int(value_str[i]))
		digit_sprite.position.x = x_pos
		digit_sprite.position.y = -digit_height
		add_child(digit_sprite)
		_digit_sprites.append(digit_sprite)
		x_pos += digit_width
func _create_digit_sprite(digit: int) -> Sprite2D:
	var sprite = Sprite2D.new()
	sprite.texture = digit_sprite_sheet
	sprite.centered = false
	sprite.region_enabled = true
	sprite.region_rect = Rect2(digit * digit_width, 0, digit_width, digit_height)
	return sprite
func reset():
	value = 0

class_name FloatingPoints

extends Node2D

const DAMAGE_COLOR = '#ff4232'
const HEAL_COLOR = '#00e982'
const COIN_COLOR = '#ffff35'
const CRITICAL_DAMAGE_COLOR = '#ff9d35'

enum TYPES {
	DAMAGE,
	HEAL,
	COIN,
	CRITICAL_DAMAGE,
}
var type: TYPES
var points: float
var points_color:
	get:
		match type:
			TYPES.DAMAGE:
				return DAMAGE_COLOR
			TYPES.HEAL:
				return HEAL_COLOR
			TYPES.COIN:
				return COIN_COLOR
			TYPES.CRITICAL_DAMAGE:
				return CRITICAL_DAMAGE_COLOR
			_:
				return '#ffffff'


func _ready():
	var tween: Tween = create_tween()
	
	var text = str(points)
	
	if type in [TYPES.HEAL, TYPES.COIN]:
		text = '+' + text
	if type == TYPES.CRITICAL_DAMAGE:
		var font_color_tween: Tween = create_tween()
		font_color_tween.set_loops()
		font_color_tween.tween_property($Label, 'theme_override_colors/font_color', Color(1, 1, 1, 1), 0.2)
		font_color_tween.tween_property($Label, 'theme_override_colors/font_color', Color(CRITICAL_DAMAGE_COLOR), 0.2)
		
		text = 'Critical! ' + text

	$Label.text = text
	$Label.add_theme_color_override("font_color", points_color)
	
	var offset_x = randi() % 6
	var offset_y = (randi() % 8) * -1 - 8
	
	tween.set_parallel(true)
	tween.tween_property(self, 'position', Vector2(offset_x, offset_y), 0.8)
	tween.tween_property(self, 'scale', Vector2(0.09, 0.09), 0.8)

	
func _on_timer_timeout():
	queue_free()
	
func test():
	pass

class_name FloatingPoints

extends Node2D

const DAMAGE_COLOR = '#ff4232'
const HEAL_COLOR = '#00e982'

enum TYPES {
	DAMAGE,
	HEAL
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
			_:
				return '#ffffff'



func _ready():
	var tween: Tween = create_tween()
	
	var text = str(points)
	
	if type == TYPES.HEAL:
		text = '+' + text

	$Label.text = text
	$Label.add_theme_color_override("font_color", points_color)
	
	var offset_x = randi() % 6
	var offset_y = (randi() % 8) * -1 - 8
	
	tween.set_parallel(true)
	tween.tween_property(self, 'position', Vector2(offset_x, offset_y), 0.8)
	tween.tween_property(self, 'scale', Vector2(0.11, 0.11), 0.8)

	
func _on_timer_timeout():
	queue_free()
	
func test():
	pass

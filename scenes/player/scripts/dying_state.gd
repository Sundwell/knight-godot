extends PlayerBaseState

@export var animated_sprite: AnimatedSprite2D

func enter():
	super()
	Engine.time_scale = 0.5
	animated_sprite.play('die')

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == 'die':
		Engine.time_scale = 1
		get_tree().reload_current_scene()

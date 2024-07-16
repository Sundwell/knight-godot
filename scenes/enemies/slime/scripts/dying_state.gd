extends SlimeBaseState

@export var animated_sprite: AnimatedSprite2D

func enter():
	# TODO Is it correct?
	slime.hitbox.queue_free()
	animated_sprite.play('die')


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == 'die':
		slime.die()

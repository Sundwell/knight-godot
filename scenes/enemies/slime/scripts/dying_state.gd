extends SlimeBaseState

@export var animated_sprite: AnimatedSprite2D

func enter():
	slime.hitbox.set_collision_mask_value(1, false)
	slime.hurtbox.set_collision_layer_value(3, false)
	animated_sprite.play('die')

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == 'die':
		slime.die()

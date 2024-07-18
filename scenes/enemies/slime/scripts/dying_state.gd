extends SlimeBaseState

@export var animated_sprite: AnimatedSprite2D

func enter():
	slime.hitbox_collision.set_deferred('disabled', true)
	slime.hurtbox_collision.set_deferred('disabled', true)
	animated_sprite.play('die')

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == 'die':
		slime.die()

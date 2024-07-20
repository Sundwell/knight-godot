extends SlimeBaseState

@export var animated_sprite: AnimatedSprite2D

func enter():
	animated_sprite.play('stun')

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == 'stun':
		state_transition.emit(self, 'Patrolling')

func exit():
	slime.hitbox.set_collision_mask_value(1, true)
	slime.can_attack = true

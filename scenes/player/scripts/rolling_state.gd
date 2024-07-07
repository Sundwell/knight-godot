extends PlayerBaseState

@export var animated_sprite : AnimatedSprite2D

var roll_direction : int

func enter():
	super()
	roll_direction = -1 if animated_sprite.flip_h else 1
	animated_sprite.play('roll')

func physics_process(delta):
	player.velocity.x = roll_direction * roll_velocity

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == 'roll':
		state_transition.emit(self, 'Idle')

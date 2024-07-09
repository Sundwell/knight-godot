extends PlayerBaseState

@export var animated_sprite : AnimatedSprite2D

var roll_direction : int

func enter():
	super()
	player.can_roll = false
	player.velocity.y = 0
	roll_direction = -1 if animated_sprite.flip_h else 1
	animated_sprite.play('roll')

func physics_process(delta):
	player.velocity.x = roll_direction * roll_velocity
	
	if Input.is_action_just_pressed("jump"):
		if player.is_on_floor():
			player.jump()
			state_transition.emit(self, 'Air')
		elif player.can_double_jump:
			player.double_jump()
			state_transition.emit(self, 'Air')
		

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == 'roll':
		if player.is_on_floor():
			state_transition.emit(self, 'Idle')
		else:
			state_transition.emit(self, 'Air')

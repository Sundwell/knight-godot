extends PlayerBaseState

@export var animated_sprite : AnimatedSprite2D

func enter():
	super()
	animated_sprite.play('run')


func physics_process(_delta):
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
		
	if player.is_on_floor() and Input.is_action_just_pressed("jump"):
		player.velocity.y = jump_velocity
		state_transition.emit(self, "Air")
	elif player.velocity.x == 0 and player.is_on_floor():
		state_transition.emit(self, 'Idle')

extends PlayerBaseState

@export var animated_sprite : AnimatedSprite2D

func enter():
	super()
	animated_sprite.play('idle')

func physics_process(_delta):
	var direction = Input.get_axis("move_left", "move_right")
	
	if player.is_on_floor() and Input.is_action_just_pressed("jump"):
		player.velocity.y = jump_velocity
		state_transition.emit(self, "Air")
	elif direction != 0 and player.is_on_floor():
		state_transition.emit(self, 'Moving')
	
	

extends PlayerBaseState

@export var animated_sprite : AnimatedSprite2D

func enter():
	super()
	player.reset_roll()
	player.velocity.x = 0
	animated_sprite.play('idle')

func physics_process(_delta):
	var direction = Input.get_axis("move_left", "move_right")
	
	if Input.is_action_just_pressed('roll') and player.can_roll:
		state_transition.emit(self, 'Rolling')
	elif player.is_on_floor() and Input.is_action_just_pressed("jump"):
		player.jump()
		state_transition.emit(self, "Air")
	elif direction != 0 and player.is_on_floor():
		state_transition.emit(self, 'Moving')
	
	

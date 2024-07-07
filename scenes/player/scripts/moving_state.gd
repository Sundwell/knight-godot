extends PlayerBaseState

@export var animated_sprite : AnimatedSprite2D
@export var jump_sound : AudioStreamPlayer2D

func enter():
	super()
	animated_sprite.play('run')

func physics_process(_delta):
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
		
	if Input.is_action_just_pressed('roll'):
		state_transition.emit(self, 'Rolling')
	if player.is_on_floor() and Input.is_action_just_pressed("jump"):
		player.velocity.y = jump_velocity
		animated_sprite.play('jump')
		jump_sound.play()	
		state_transition.emit(self, "Air")
	elif player.velocity.x == 0 and player.is_on_floor():
		state_transition.emit(self, 'Idle')

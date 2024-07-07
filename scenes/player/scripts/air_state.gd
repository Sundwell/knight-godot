extends PlayerBaseState

@export var animated_sprite : AnimatedSprite2D
@export var jump_sound : AudioStreamPlayer2D

func enter():
	super()
	animated_sprite.play('jump')
	jump_sound.play()	

func physics_process(_delta):
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
		
	if player.is_on_floor():
		if player.velocity.x == 0:
			state_transition.emit(self, 'Idle')
		else:
			state_transition.emit(self, 'Moving')

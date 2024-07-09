extends PlayerBaseState

func enter():
	super()

func physics_process(_delta):
	if Input.is_action_just_pressed('roll') and player.can_roll:
		state_transition.emit(self, 'Rolling')
		return

	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
		
	if Input.is_action_just_pressed("jump") and player.can_double_jump:
		player.double_jump()
		
	if player.is_on_floor():
		if player.velocity.x == 0:
			state_transition.emit(self, 'Idle')
		else:
			state_transition.emit(self, 'Moving')

extends State

@export var slime: SlimeBoss

@export var animated_sprite: AnimatedSprite2D

func enter():
	animated_sprite.play('wander')
	
func physics_process(_delta):
	slime.move()
	
	if slime.player_in_view and slime.can_jump_attack:
		state_transition.emit(self, 'JumpAttack')
	

extends State

@export var slime: SlimeBoss
@export var animated_sprite: AnimatedSprite2D
var has_attacked = false

func enter():
	has_attacked = false
	slime.velocity.x = 0
	animated_sprite.play('jump_preparation')
	
func physics_process(delta):
	if slime.is_on_floor() and has_attacked:
		state_transition.emit(self, 'Wandering')

func _on_animated_sprite_2d_animation_finished():
	slime.can_jump_attack = false
	slime.velocity.y = -300
	slime.move()
	has_attacked = true
	
	await get_tree().create_timer(3).timeout
	slime.can_jump_attack = true
	

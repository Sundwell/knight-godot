extends CharacterBody2D
class_name Player

@export var jump_velocity = -300.0
@export var double_jump_velocity = -200.0

@onready var jump_sound = $JumpSound
@onready var animated_sprite = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_double_jump : bool = true
var can_roll : bool = true

func _process(delta):
	update_facing()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		reset_double_jump()
		reset_roll()

	move_and_slide()
	
func update_facing():
	if velocity.x > 0:
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		animated_sprite.flip_h = true
		
func jump():
	velocity.y = jump_velocity
	animated_sprite.play('jump')
	jump_sound.play()
	
func double_jump():
	can_double_jump = false
	velocity.y = double_jump_velocity
	jump_sound.play()
	
func reset_double_jump():
	can_double_jump = true
	
func reset_roll():
	can_roll = true

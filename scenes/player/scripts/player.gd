extends CharacterBody2D
class_name Player

@export var ROLL_VELOCITY = 250.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
@onready var jump_sound = $JumpSound
@onready var timer = $Timer

var is_rolling = false

func _process(delta):
	update_facing()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	#if Input.is_action_just_pressed("roll") and not is_rolling:
		#is_rolling = true
		#animated_sprite.play('roll')
		#var roll_direction = -1 if animated_sprite.flip_h == true else 1
		#velocity.x = ROLL_VELOCITY * roll_direction
	
	move_and_slide()
	
func update_facing():
	if velocity.x > 0:
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		animated_sprite.flip_h = true

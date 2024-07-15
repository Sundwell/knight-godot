class_name Player

extends CharacterBody2D

const MAX_HEALTH: float = 100.0

@export var jump_velocity = -300.0
@export var double_jump_velocity = -200.0

@onready var jump_sound = $SFX/JumpSound
@onready var hurt_sound = $SFX/HurtSound
@onready var animated_sprite = $AnimatedSprite2D
@onready var state_machine: StateMachine = $PlayerStateMachine
@onready var health_bar = $HealthBar

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_double_jump: bool = true
var can_roll: bool = true
var is_dead: bool = false
var invincible: bool = false
var health: float = MAX_HEALTH:
	set(new_health):
		health = min(MAX_HEALTH, new_health)
		health_bar.health = health
var damage: float = 1.0

func _ready():
	health_bar.init_health(health)

func _process(_delta):
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
	
func take_damage(damage: float):
	if is_dead or invincible:
		return
		
	invincible = true
	hurt_sound.play()
	health -= damage
	animated_sprite.modulate.a = 0.5
	set_collision_layer_value(2, false)
	
	if health == 0:
		animated_sprite.modulate.a = 1
		die()
	else:
		await get_tree().create_timer(0.6).timeout
		animated_sprite.modulate.a = 1
		invincible = false
		set_collision_layer_value(2, true)
	
func die():
	is_dead = true
	state_machine.force_change_state('Dying')
	

func _on_jump_damage_area_entered(area):
	if velocity.y <= 0:
		return
	
	var enemy = area.get_parent()
	if enemy:
		enemy.take_damage(damage)
	
	jump()

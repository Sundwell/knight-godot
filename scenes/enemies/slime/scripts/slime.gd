class_name Slime

extends Node2D

const SPEED = 60

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var hitbox = $Hitbox
@onready var health_bar = $HealthBar
@onready var state_machine = $SlimeStateMachine
@onready var hurt_sound = $HurtSound

var direction = 1
@export var max_health: float = 2.0
@export var health: float = max_health:
	set(new_health):
		health = min(max_health, new_health)
		health_bar.health = health
@export var damage: float = 25.0

func _ready():
	health_bar.init_health(health)
	
func move(delta: float):
	if ray_cast_left.is_colliding():
		direction = 1
	elif ray_cast_right.is_colliding():
		direction = -1
	
	animated_sprite_2d.flip_h = direction == -1
	
	position.x += direction * SPEED * delta
	
func take_damage(_damage: float):
	health -= _damage
	hurt_sound.play()
	
	if health == 0:
		state_machine.force_change_state('Dying')
	else:
		state_machine.force_change_state('Stunned')
		
func die():
	queue_free()

func _on_hitbox_area_entered(area):
	if area.is_in_group('Player Hurtbox'):
		var player: Player = area.get_parent()
		player.take_damage(damage)

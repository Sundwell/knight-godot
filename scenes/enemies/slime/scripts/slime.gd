class_name Slime

extends Node2D

const SPEED = 60

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var hitbox_collision: CollisionShape2D = $Hitbox/CollisionShape2D
@onready var hurtbox_collision: CollisionShape2D = $Hurtbox/CollisionShape2D
@onready var health_bar = $HealthBar
@onready var state_machine = $SlimeStateMachine
@onready var hurt_sound = $HurtSound

var floating_points_scene = preload('res://scenes/floating_points.tscn')
var enemy_drop_scene = preload("res://scenes/enemy_drop.tscn")
var direction = 1
var can_attack := true
@export var max_health: float = 1.0
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
	can_attack = false
	hitbox_collision.set_deferred('disabled', true)
	health -= _damage
	
	var floating_points = floating_points_scene.instantiate()
	floating_points.points = _damage
	floating_points.type = floating_points.TYPES.DAMAGE
	add_child(floating_points)
	
	hurt_sound.play()
	
	if health <= 0:
		state_machine.force_change_state('Dying')
	else:
		state_machine.force_change_state('Stunned')
		
func die():
	var enemy_drop = enemy_drop_scene.instantiate()
	enemy_drop.position = position
	get_tree().current_scene.add_child(enemy_drop)
	queue_free()

func _on_hitbox_area_entered(area):
	if area.is_in_group('Player Hurtbox') and can_attack:
		var player: Player = area.get_parent()
		player.take_damage(damage)

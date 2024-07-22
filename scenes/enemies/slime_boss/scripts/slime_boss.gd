class_name SlimeBoss

extends CharacterBody2D

const WANDER_SPEED = 30
const RUN_SPEED = 90

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_player_right: RayCast2D = $LookPlayerRaycasts/Right
@onready var ray_cast_player_left: RayCast2D = $LookPlayerRaycasts/Left
@onready var hitbox: Area2D = $Hitbox
@onready var hurtbox: Area2D = $Hurtbox
@onready var health_bar = $HealthBar
@onready var state_machine = $SlimeBossStateMachine
@onready var hurt_sound = $HurtSound

var floating_points_scene = preload('res://scenes/floating_points.tscn')
var enemy_drop_scene = preload("res://scenes/enemy_drop.tscn")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1
var can_attack := true
var player_in_view := false
var can_jump_attack := true
@export var max_health: float = 5.0
@export var health: float = max_health:
	set(new_health):
		health = min(max_health, new_health)
		health_bar.health = health
@export var damage: float = 25.0

func _ready():
	health_bar.init_health(health)
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	var player_on_left = ray_cast_player_left.is_colliding()
	var player_on_right = ray_cast_player_right.is_colliding()
	
	player_in_view = player_on_left or player_on_right
	
	move_and_slide()
	
func move():
	if player_in_view:
		direction = -1 if ray_cast_player_left.is_colliding() else 1
	else:
		if ray_cast_left.is_colliding():
			direction = 1
		elif ray_cast_right.is_colliding():
			direction = -1
	
	animated_sprite_2d.flip_h = direction == -1
	
	var speed = RUN_SPEED if player_in_view else WANDER_SPEED
	
	velocity.x = direction * speed
	
func take_damage(_damage: float):
	hitbox.set_collision_mask_value(1, false)
	can_attack = false
	
	health -= _damage
	
	var floating_points = floating_points_scene.instantiate()
	floating_points.points = _damage
	floating_points.type = floating_points.TYPES.DAMAGE
	add_child(floating_points)
	
	hurt_sound.play()
	
	if health <= 0:
		state_machine.force_change_state('Dying')
		return
	
	await get_tree().create_timer(0.1).timeout
	can_attack = true
	hitbox.set_collision_mask_value(1, true)
		
func die():
	for index in 10:
		var enemy_drop: EnemyDrop = enemy_drop_scene.instantiate()
		enemy_drop.position = Vector2(
			randf_range(position.x - 10, position.x + 10), 
			randf_range(position.y - 20, position.y + 20)
			)
		enemy_drop.randomize_drop = false
		get_tree().current_scene.add_child(enemy_drop)

	queue_free()

func _on_hitbox_area_entered(area):
	if area.is_in_group('Player Hurtbox') and can_attack:
		var player: Player = area.get_parent()
		var is_critical_hit = not is_on_floor()
		player.take_damage(damage * 2 if is_critical_hit else damage)

extends Node2D

const SPEED = 60

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var damage_zone = $DamageZone

var direction = 1
@export var damage: float = 25.0

func _ready():
	damage_zone.init_damage(damage)

func _process(delta):
	if ray_cast_left.is_colliding():
		direction = 1
	elif ray_cast_right.is_colliding():
		direction = -1
	
	animated_sprite_2d.flip_h = direction == -1
	
	position.x += direction * SPEED * delta

class_name Fruit

extends Pickup

enum TYPES { SMALL, MEDIUM, BIG }

@export var type: TYPES
var is_random_fruit: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var heal: float

func _ready():
	if is_random_fruit:
		type = TYPES.values()[randi() % TYPES.size()]

	match type:
		TYPES.SMALL:
			heal = 15
			sprite.frame = 0
		TYPES.MEDIUM:
			heal = 20
			sprite.frame = 1
		TYPES.BIG:
			heal = 25
			sprite.frame = 2

func pickup():
	animation_player.play('pickup')

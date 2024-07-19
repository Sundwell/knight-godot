class_name Fruit

extends Pickup

enum Types { SMALL, MEDIUM, BIG }

@export var type: Types

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var heal: float

func _ready():
	match type:
		Types.SMALL:
			heal = 15
			sprite.frame = 0
		Types.MEDIUM:
			heal = 20
			sprite.frame = 1
		Types.BIG:
			heal = 25
			sprite.frame = 2

func pickup():
	animation_player.play('pickup')

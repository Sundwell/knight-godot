class_name Coin

extends Pickup

var game_manager: GameManager
@onready var animation_player = $AnimationPlayer

func _ready():
	game_manager = get_tree().get_first_node_in_group('GameManager')

func pickup():
	game_manager.add_point()
	animation_player.play('pickup')

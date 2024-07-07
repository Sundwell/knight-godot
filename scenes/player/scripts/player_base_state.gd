extends State
class_name PlayerBaseState

@export var speed = 130.0
@export var jump_velocity = -300.0
var player : Player

func enter():
	player = get_tree().get_first_node_in_group('Player')

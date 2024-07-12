class_name PlayerBaseState

extends State

@export var speed = 130.0
@export var jump_velocity = -300.0
@export var double_jump_velocity = -200.0
@export var roll_velocity = 200.0

var player : Player

func enter():
	player = get_tree().get_first_node_in_group('Player')

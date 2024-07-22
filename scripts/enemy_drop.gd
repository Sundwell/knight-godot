class_name EnemyDrop

extends Node2D

var coin_scene = preload("res://scenes/coin.tscn")
var fruit_scene = preload("res://scenes/fruit.tscn")
enum TYPES { COIN, FRUIT }
var type: TYPES
var randomize_drop: bool = true

func _ready():
	var drop_scene
	
	if randomize_drop:
		var enum_values = TYPES.values()
		type = enum_values[randi() % enum_values.size()]
	
	match type:
		TYPES.COIN:
			drop_scene = coin_scene
		TYPES.FRUIT:
			drop_scene = fruit_scene
			
	if drop_scene:
		var drop: Pickup = drop_scene.instantiate()
		
		if drop is Fruit:
			drop.is_random_fruit = true
		
		add_child(drop)

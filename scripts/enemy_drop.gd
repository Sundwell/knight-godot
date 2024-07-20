class_name EnemyDrop

extends Node2D

var coin_scene = preload("res://scenes/coin.tscn")
var fruit_scene = preload("res://scenes/fruit.tscn")
enum TYPES { COIN, FRUIT }

func _ready():
	var drop_scene
	
	var enum_values = TYPES.values()
	
	var type: TYPES = enum_values[randi() % enum_values.size()]
	
	match type:
		TYPES.COIN:
			drop_scene = coin_scene
		TYPES.FRUIT:
			drop_scene = fruit_scene
			
	if drop_scene:
		var drop: Pickup = drop_scene.instantiate()
		add_child.call_deferred(drop)

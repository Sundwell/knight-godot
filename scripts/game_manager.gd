extends Node

@onready var score = $Label

var points = 0

func add_point():
	points += 1
	score.text = "You've collected " + str(points) + " points!"

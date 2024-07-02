extends Node

@onready var score = $Score

var points = 0

func add_point():
	points += 1
	score.text = "You've collected " + str(points) + " points!"

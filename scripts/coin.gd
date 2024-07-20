class_name Coin

extends Pickup

@onready var animation_player = $AnimationPlayer

func pickup():
	#GameManager.add_point()
	animation_player.play('pickup')

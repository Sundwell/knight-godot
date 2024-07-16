extends SlimeBaseState

@export var animated_sprite: AnimatedSprite2D


func enter():
	animated_sprite.play('idle')
	
func process(delta):
	slime.move(delta)

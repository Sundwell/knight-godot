extends Area2D

var damage: float:
	set(new_damage):
		if new_damage < 0:
			damage = 0
		else:
			damage = new_damage

func init_damage(_damage: float):
	damage = _damage

func _on_body_entered(body):
	if body is Player:
		body.take_damage(damage)

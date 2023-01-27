extends Area2D
class_name Hitbox

@export var damage = 0;

func _on_body_entered(body):
	if body is Player:
		body.damage(self, damage)

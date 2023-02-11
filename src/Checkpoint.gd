extends Area2D

@onready var animatedSprite: AnimatedSprite2D = get_node("AnimatedSprite2D")


func _on_body_entered(body):
	if not body is Player: return
	animatedSprite.play("Reached")
	Events.checkpoint_reached.emit(self.global_position)

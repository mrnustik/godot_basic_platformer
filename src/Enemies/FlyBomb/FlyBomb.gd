extends Path2D

enum AnimationType {
	Loop,
	Bounce
}

@export var animationType: AnimationType
@onready var animationPlayer: AnimationPlayer = get_node("AnimationPlayer")


func _ready():
	match(animationType):
		AnimationType.Loop: animationPlayer.play("MoveLoop")
		AnimationType.Bounce: animationPlayer.play("MoveBounce")

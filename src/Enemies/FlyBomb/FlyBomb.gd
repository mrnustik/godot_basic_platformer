@tool
extends Path2D

enum AnimationType {
	Loop,
	Bounce
}

@export var animationType: AnimationType:
	set(value): 
		animationType = value
		play_current_animation()

@export var speed: float = 1.0:
	set(value):
		speed = value
		play_current_animation()

@onready var animationPlayer: AnimationPlayer = get_node("AnimationPlayer")

func _ready():
	play_current_animation()

func play_current_animation():
	if animationPlayer == null:
		return
	animationPlayer.speed_scale = speed
	
	match(animationType):
		AnimationType.Loop: animationPlayer.play("MoveLoop")
		AnimationType.Bounce: animationPlayer.play("MoveBounce")

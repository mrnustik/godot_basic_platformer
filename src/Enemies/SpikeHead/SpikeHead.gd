extends CharacterBody2D


var direction: = Vector2.RIGHT

const SPEED = 60.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var rightFloorRayCast : RayCast2D = get_node("RightFloorRayCast")
@onready var leftFloorRayCast : RayCast2D = get_node("LeftFloorRayCast")


func _physics_process(delta):
	if is_on_wall() or is_on_edge():
		direction *= -1
		
	apply_gravity(delta)
	velocity.x = direction.x * SPEED
	
	
	
	move_and_slide()


func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta


func is_on_edge():
	return not leftFloorRayCast.is_colliding() or not rightFloorRayCast.is_colliding()

extends CharacterBody2D
class_name Player

const SPEED = 100.0
const JUMP_VELOCITY = -120.0
const INITIAL_HEALTH = 100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var health = INITIAL_HEALTH

@onready var animationSprite: AnimatedSprite2D = get_node("AnimatedSprite2d")


func _physics_process(delta):
	apply_gravity(delta)
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		apply_acceleration(direction)
	else:
		apply_friction()

	print("Velocity.x= %d " % velocity.x)

	if velocity.x != 0:
		animationSprite.play("Run")
		animationSprite.flip_h = velocity.x > 0
	elif velocity.y != 0:
		animationSprite.play("Jump")
	else:
		animationSprite.play("Idle")

	move_and_slide()

func apply_acceleration(direction: float):
	velocity.x = move_toward(velocity.x, direction * SPEED, 10)

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, 10)

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func damage(origin: Node2D, damage: int):
	health -= damage;
	if health < 0:
		get_tree().reload_current_scene()
	var knockBackDirection = origin.position.direction_to(self.position)
	velocity = knockBackDirection * 200
	

extends CharacterBody2D
class_name Player

const SPEED = 100.0
const JUMP_VELOCITY = -160.0
const INITIAL_HEALTH = 100

enum { Move, Climb }

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var health = INITIAL_HEALTH
var state = Move

@onready var animationSprite: AnimatedSprite2D = get_node("AnimatedSprite2d")
@onready var ladderDetector: RayCast2D = get_node("LadderDetector")


func _physics_process(delta):
	var input = Vector2.ZERO
	input.x = Input.get_axis("ui_left", "ui_right")
	input.y = Input.get_axis("ui_up", "ui_down")
	
	match(state):
		Move: move_state(delta, input)
		Climb: climb_state(delta, input)

func climb_state(delta, input: Vector2):
	if not is_on_ladder():
		state = Move

	velocity = input * 50
	animationSprite.play("Climb")
	move_and_slide()

func move_state(delta, input: Vector2):
	if is_on_ladder():
		state = Climb
	
	apply_gravity(delta)
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if input.x:
		apply_acceleration(input.x)
	else:
		apply_friction()

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

func is_on_ladder():
	return ladderDetector.is_colliding() and ladderDetector.get_collider() is Ladder

func damage(origin: Node2D, damage: int):
	health -= damage;
	if health < 0:
		get_tree().reload_current_scene()
	var knockBackDirection = origin.position.direction_to(self.position)
	velocity = knockBackDirection * 200
	

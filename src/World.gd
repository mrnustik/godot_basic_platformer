extends Node2D

const PlayerScene = preload("res://Player.tscn")

@onready var player: Player = get_node("Level1/Player")
@onready var camera: Camera2D = get_node("Camera2D")
@onready var playerHealth: PlayerHealth = get_node("CanvasLayer/PlayerHealth")

var player_spawn_location: Vector2

func _ready():
	player_spawn_location = player.global_position
	player.connect_camera(camera)
	playerHealth.set_player(player)
	Events.player_died.connect(_on_player_died)
	Events.checkpoint_reached.connect(_on_checkpoint_reached)

func _on_player_died():
	var player = PlayerScene.instantiate()
	player.global_position = player_spawn_location
	add_child(player)
	player.connect_camera(camera)
	playerHealth.set_player(player)

func _on_checkpoint_reached(position: Vector2):
	player_spawn_location = position

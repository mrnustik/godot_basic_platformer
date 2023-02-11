extends Node2D

const PlayerScene = preload("res://Player.tscn")

@onready var player: Player = get_node("Level1/Player")
@onready var camera: Camera2D = get_node("Camera2D")

var originalPlayerLocation: Vector2

func _ready():
	originalPlayerLocation = player.global_position
	player.connect_camera(camera)
	Events.player_died.connect(_on_player_died)

func _on_player_died():
	var player = PlayerScene.instantiate()
	player.connect_camera(camera)
	player.global_position = originalPlayerLocation
	add_child(player)

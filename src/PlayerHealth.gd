extends Label

var currentHealth = 100

@onready var player: Player = get_node("../../Level1/Player")

func _process(delta):
	if player.health != currentHealth:
		currentHealth = player.health
		text = "Health: %d" % currentHealth
	pass

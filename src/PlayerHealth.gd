extends Label
class_name PlayerHealth

var currentHealth = 100

var player: Player

func _process(delta):
	if player == null: return
	if player.health != currentHealth:
		currentHealth = player.health
		text = "Health: %d" % currentHealth

func set_player(player: Player):
	self.player = player

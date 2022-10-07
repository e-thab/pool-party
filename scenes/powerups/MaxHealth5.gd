extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "MAX HEALTH"
	desc = "+5% max health."


func power():
	var player = get_tree().get_nodes_in_group("player")[0]
	player.add_stats_percent(Stats.MAX_HEALTH, 5)
	print('+5% max health. max health = ', player.max_health)

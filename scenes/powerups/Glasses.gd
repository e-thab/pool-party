extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "DINKY GLASSES"
	desc = "Learn secrets long forgotten, predict the future, get one more choice on level up."


func power():
	var player = get_tree().get_nodes_in_group("player")[0]
	player.add_stats_literal(Stats.LVL_CHOICES, 1)
	print('you feel 30% smarter. lvl_choices = ', player.lvl_choices)

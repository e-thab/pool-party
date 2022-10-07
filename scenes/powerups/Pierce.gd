extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "PIERCE"
	desc = "Shots pierce 1 more enemy."


func power():
	var player = get_tree().get_nodes_in_group("player")[0]
	player.add_stats_literal(Stats.PIERCE, 1)
	print('you feel 1% percier. pierce = ', player.pierce)

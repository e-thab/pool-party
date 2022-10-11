extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "PIERCE"
	desc = "Shots pierce 1 more enemy."


func power():
	var player = Game.get_player()
	player.add_stats(Stats.PIERCE, 1)

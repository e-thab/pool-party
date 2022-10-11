extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "MAX HEALTH"
	desc = "+5% max health."


func power():
	var player = Game.get_player()
	player.add_stats(Stats.MAX_HEALTH, 5)

extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "SPREAD"
	desc = "+10 degrees "


func power():
	var player = Game.get_player()
	player.add_stats_literal(Stats.SHOT_SPREAD, 10)
	print('+10 degree spread. spread = ', player.shot_spread)

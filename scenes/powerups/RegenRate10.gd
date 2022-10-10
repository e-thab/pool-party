extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "REGEN TIME"
	desc = "-0.25 seconds to regen"


func power():
	var player = Game.get_player()
	player.add_stats_literal(Stats.REGEN_TIME, -0.25)
	print('-0.25 seconds to regen. regen time = ', player.regen_time)

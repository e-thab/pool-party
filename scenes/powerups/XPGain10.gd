extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "XP GAIN"
	desc = "+10% XP Gain"


func power():
	var player = Game.get_player()
	player.add_stats_percent(Stats.XP_GAIN, 10)
	print('+10% xp gain. xp gain = ', player.xp_gain)

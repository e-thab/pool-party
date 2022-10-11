extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "TAPED MAGS"
	desc = "+10% reload speed"


func power():
	var player = Game.get_player()
	player.add_stats(Stats.RELOAD_SPEED, 10)

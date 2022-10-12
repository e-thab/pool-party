extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "AMMO"
	desc = "+1 ammo per tank"


func power():
	var player = Game.get_player()
	player.add_stats(Stats.EXTRA_AMMO, 1)

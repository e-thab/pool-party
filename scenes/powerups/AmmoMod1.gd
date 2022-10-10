extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "AMMO"
	desc = "+1 shot per tank"


func power():
	var player = Game.get_player()
	player.add_stats_literal(Stats.AMMO_MOD, 1)
	print('+1 ammo_mod. ammo_mod = ', player.ammo_mod)

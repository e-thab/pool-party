extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "TACTICAL SCOPE"
	desc = "+10% crit chance"


func power():
	var player = Game.get_player()
	player.add_stats(Stats.CRIT_CHANCE, 10)

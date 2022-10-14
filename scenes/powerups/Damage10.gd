extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "DAMAGE"
	desc = "+10% damage"


func power():
	var player = Game.get_player()
	player.add_stats(Stats.DAMAGE, 10)

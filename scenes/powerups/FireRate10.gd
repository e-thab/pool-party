extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "FIRE RATE"
	desc = "+10% fire rate"


func power():
	var player = Game.get_player()
	player.add_stats(Stats.FIRE_RATE, 10)

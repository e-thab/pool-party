extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "SPEED"
	desc = "+10% move speed."


func power():
	var player = Game.get_player()
	player.add_stats_percent(Stats.SPEED, 10)
	print('+10% move speed. speed = ', player.speed)

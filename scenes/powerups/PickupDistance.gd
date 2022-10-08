extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "PICKUP DISTANCE"
	desc = "+10% pickup distance."


func power():
	var player = Game.get_player()
	player.add_stats_percent(Stats.PICKUP_DIST, 10)
	print('+10% pickup distance. distance = ', player.pickup_dist)

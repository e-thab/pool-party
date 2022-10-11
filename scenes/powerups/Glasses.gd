extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "DINKY GLASSES"
	desc = "Learn secrets long forgotten, predict the future, get one more choice on level up."


func power():
	var player = Game.get_player()
	player.add_stats(Stats.LVL_CHOICES, 1)

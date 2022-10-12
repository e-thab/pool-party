extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "PROJECTILE SIZE"
	desc = "+10% projectile size"


func power():
	var player = Game.get_player()
	player.add_stats(Stats.SHOT_SIZE, 10)

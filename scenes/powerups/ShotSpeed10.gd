extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "PROJECTILE SPEED"
	desc = "+10% projectile speed"


func power():
	var player = Game.get_player()
	player.add_stats(Stats.SHOT_SPEED, 10)

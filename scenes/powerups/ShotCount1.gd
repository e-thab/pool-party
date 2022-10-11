extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "SHOT COUNT"
	desc = "+1 projectile per shot"


func power():
	var player = Game.get_player()
	player.add_stats(Stats.SHOT_COUNT, 1)

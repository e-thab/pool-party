extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _init():
	title = "SHOT COUNT"
	desc = "+1 projectile per shot"


func power():
	var player = Game.get_player()
	player.add_stats_literal(Stats.SHOT_COUNT, 1)
	print('+1 shot count. shot count = ', player.shot_count)

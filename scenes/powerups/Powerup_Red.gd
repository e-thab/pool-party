extends "res://scenes/powerups/parent/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _init():
	title = "RED"
	desc = "This powerup is red.\n+30% warmth."


func power():
	print('you feel 30% warmer.')

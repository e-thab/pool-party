extends "res://scripts/Pickup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


func pickup():
	player.add_xp(1)
	queue_free()

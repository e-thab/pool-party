extends "res://scenes/powerups/Powerup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _init():
	title = "RED"
	desc = "This powerup is red.\n+30% warmth."


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureRect_gui_input(event):
	if event.is_action("primary_fire") and event.is_pressed():
		print('click red')

extends Control


# Declare member variables here. Examples:
var color = Color.white


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Item2_mouse_entered():
	modulate = Color.red


func _on_Item2_mouse_exited():
	modulate = color


func _on_Item2_gui_input(event):
	if event.is_action("primary_fire") and event.is_pressed():
		print('click')
		color = Color.black if color == Color.white else Color.white

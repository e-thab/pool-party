extends Node


# Declare member variables here. Examples:
onready var player = get_parent().get_parent()
var last_pos = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var pos = player.position
	if pos != last_pos:
		Engine.time_scale = 1
	else:
		Engine.time_scale = 0.2
	
	last_pos = pos

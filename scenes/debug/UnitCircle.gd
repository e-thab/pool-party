extends Node2D


# Declare member variables here. Examples:
onready var poly = $Polygon2D
var cursor_pos = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	cursor_pos = get_global_mouse_position()
	poly.rotation = cursor_pos.angle_to_point(position)
	
	var r = poly.rotation
	$Radians.text = str(r / PI)
	$Degrees.text = str(rad2deg(r))

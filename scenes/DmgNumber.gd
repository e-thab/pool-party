extends Node2D


# Declare member variables here. Examples:
# var a = 2
onready var wait = $Fade.wait_time


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Number.self_modulate.a = (1 / wait) * $Fade.time_left
	position.y -= 50 * delta


func set_num(n):
	#n = stepify(n, 0.1)  # round to tenths place
	$Number.text = str(n)
	#$Number.self_modulate = Color(1, 1 - n/30.0, 1 - n/30.0, 1) # number is white at 0 and red at 30


func _on_Fade_timeout():
	queue_free()

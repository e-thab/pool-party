extends Node


# Declare member variables here. Examples:
var signals = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func queue_pause():
	signals += 1
	get_tree().paused = true
	print('queueing pause. pause signals = ', signals)


func queue_unpause():
	signals -= 1
	if signals <= 0:
		get_tree().paused = false
		signals = 0  # Set signals back to 0 in case unpause was queued too much somehow
	print('dequeueing pause. pause signals = ', signals)


func pause(pause):
	if pause:
		queue_pause()
	else:
		queue_unpause()

extends Node


# Declare member variables here. Examples:
var flags = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func queue_pause():
	flags.append(1)
	get_tree().paused = true
	print('queueing pause. pause signals = ', len(flags))


func queue_unpause():
	flags.pop_back()
	if not flags:
		get_tree().paused = false
	print('dequeueing pause. pause signals = ', len(flags))


func pause(pause):
	if pause:
		queue_pause()
	else:
		queue_unpause()

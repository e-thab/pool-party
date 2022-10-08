extends Node


# Declare member variables here. Examples:
var pause_signals = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func queue_pause():
	pause_signals.append(1)
	get_tree().paused = true
	print('queueing pause. pause signals = ', len(pause_signals))


func queue_unpause():
	pause_signals.pop_back()
	if not pause_signals:
		get_tree().paused = false
	print('dequeueing pause. pause signals = ', len(pause_signals))


func _on_pause(pause):
	if pause:
		queue_pause()
	else:
		queue_unpause()

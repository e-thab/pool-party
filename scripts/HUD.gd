extends CanvasLayer


# Declare member variables here. Examples:
var time = 0
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func update_time(hp):
	$HealthLabel.text = str(hp)


func _on_RoundTimer_timeout():
	time += 1
	var seconds = "%02d" % (time % 60)
	var minutes = "%02d" % (int(time / 60) % 60)
	$TimeLabel.text = minutes + ":" + seconds
	

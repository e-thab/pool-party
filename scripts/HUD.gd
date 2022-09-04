extends CanvasLayer


# Declare member variables here. Examples:
var time = 0
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			$PauseLabel.hide()
			get_tree().paused = false
		else:
			get_tree().paused = true
			$PauseLabel.show()


func update_time(hp):
	$HealthLabel.text = str(hp)


func _on_RoundTimer_timeout():
	time += 1
	var seconds = "%02d" % (time % 60)
	var minutes = "%02d" % (int(time / 60) % 60)
	$TimeLabel.text = minutes + ":" + seconds
	

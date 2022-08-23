extends TextEdit

signal value_entered(val)
var np = 0

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if has_focus():
		if Input.is_action_pressed("ui_accept"):
			np = int(text)
			text = str(np)
			emit_signal("value_entered", np)
			print("health set at " + str(np))
			release_focus()

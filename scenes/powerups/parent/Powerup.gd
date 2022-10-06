extends TextureRect


signal hover
signal choose

# Declare member variables here. Examples:
var title = 'test title'
var desc = 'test description'

var highlight_color = Color(1, 1, 1, 0.392)
var background_color = Color(0, 0, 0, 0.706)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	pass


func power():  # the function to redefine for children
	pass  # do power up stuff here


func _on_Powerup_mouse_entered():
	$Highlight.visible = true
	$Background.self_modulate = highlight_color
	emit_signal("hover", title, desc)


func _on_Powerup_mouse_exited():
	$Highlight.visible = false
	$Background.self_modulate = background_color


func _on_Powerup_gui_input(event):
	if event.is_action("primary_fire") and event.is_pressed():
		power()
		emit_signal("choose")

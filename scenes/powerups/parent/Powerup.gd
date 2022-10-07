extends Control


signal hover
signal choose

# Declare member variables here. Examples:
var title = 'test title'
var desc = 'test description'

#var highlight_color = Color(0, 0, 0, 0.7)
#var background_color = Color(0, 0, 0, 0.7)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	pass


func power():  # the function to redefine for children
	pass  # do power up stuff here


func resize(x, y):
	print('resizing')
	var x_offset = (rect_size.x - x)/2.0
	var y_offset = (rect_size.y - y)/2.0
	rect_position += Vector2(x_offset, y_offset)
	rect_size = Vector2(x, y)


func _on_Powerup_mouse_entered():
	$Highlight.visible = true
	resize(120, 120)
	#$Background.self_modulate = highlight_color
	emit_signal("hover", title, desc)


func _on_Powerup_mouse_exited():
	$Highlight.visible = false
	resize(100, 100)
	#$Background.self_modulate = background_color


func _on_Powerup_gui_input(event):
	if event.is_action("primary_fire") and event.is_pressed():
		power()
		emit_signal("choose")

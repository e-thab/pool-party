extends TextureRect


# Declare member variables here. Examples:
var title = 'title'
var desc = 'description'


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#$Label.text = str(rect_position)
	pass


func _on_TextureRect_mouse_entered():
	$Highlight.visible = true


func _on_TextureRect_mouse_exited():
	$Highlight.visible = false


func _on_TextureRect_gui_input(event):
	if event.is_action("primary_fire") and event.is_pressed():
		print('click')

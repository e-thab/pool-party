extends Sprite


# Declare member variables here. Examples:
export(PackedScene) var projectile


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("primary_fire"):
		shoot()
	
	flip_v = global_rotation < (-PI/2) or global_rotation > (PI/2)


func shoot():
	print("shoot shotgun")

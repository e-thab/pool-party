extends CanvasLayer


# Declare member variables here. Examples:
var powerups = ['pickup_dist', 'max_health', 'speed', 'ammo_mod', 'damage', 'fire_rate',
				'reload_speed', 'shot_speed', 'shot_count', 'shot_spread', 'pierce']


# Called when the node enters the scene tree for the first time.
func _ready():
	var choices = rand_choice(powerups, 3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
#	if Input.is_action_just_pressed("use_item"):
#		print(rand_choice(powerups, 3))
	pass


func rand_choice(arr, amt):
	# randomly choose {amt} items from {arr}
	var choices = []
	
	while len(choices) < amt:
		var tmp = arr[randi() % len(arr)]
		if not (tmp in choices):
			choices.append(tmp)
	
	return choices

extends CanvasLayer


export(Array, PackedScene) var powerups

onready var centerx = $Control.rect_size.x/2.0
onready var centery = $Control.rect_size.y/2.0
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	if get_tree().current_scene.name == "LevelUp":
		randomize()
		var choices = rand_choice(powerups, 8)
		show_choices(choices)
	else:
		player = get_tree().get_nodes_in_group("player")[0]
		player.connect("level_up", self, "_on_level_up")
		# generate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	if Input.is_action_just_pressed("use_item"):
#		print(rand_choice(powerups, 3))
	#pass


func _on_level_up():
	generate()


func generate():
	visible = true
	var choices = rand_choice(powerups, player.lvl_choices)
	show_choices(choices)
	get_tree().paused = true # problem with main pause menu


func show_choices(arr):
	# given an array of scenes, spawn all scenes in a circle
	var rngi = len(arr)
	var theta = 0
	
	for i in range(rngi):
		var inst = arr[i].instance()
		$Control.add_child(inst)
		
		var x = centerx + centerx * cos(theta)
		var y = centery - centery * sin(theta)
		x = x - inst.rect_size.x/2.0
		y = y - inst.rect_size.y/2.0
		theta += PI / (rngi/2.0)
		
		inst.rect_position = Vector2(x, y)


func clear():
	for x in $Control.get_children():
		x.queue_free()
	get_tree().paused = false # problem with main pause menu


func rand_choice(arr, amt):
	# randomly choose {amt} items from {arr}
	var choices = []
	
	while len(choices) < amt:
		var tmp = arr[randi() % len(arr)]
		if not (tmp in choices):
			choices.append(tmp)
	
	return choices

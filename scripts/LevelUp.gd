extends CanvasLayer


export(Array, PackedScene) var powerups

onready var centerx = $Placement.rect_size.x/2.0
onready var centery = $Placement.rect_size.y/2.0
onready var player = Game.get_player()
var level_signals = 0
var is_leveling = false


# Called when the node enters the scene tree for the first time.
func _ready():
	player = Game.get_player()
	player.connect("level_up", self, "_on_level_up")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	if Input.is_action_just_pressed("use_item"):
#		print(rand_choice(powerups, 3))
	#pass


# queue allows multiple levels at once without everything happening at once
func _on_level_up():
	queue_level_up()


func queue_level_up():
	level_signals += 1
	if not is_leveling:
		is_leveling = true
		PauseManager.pause(true)
		generate()


func generate():
	$Placement.visible = true
	$Info.visible = true
	var choices = rand_choice(powerups, player.lvl_choices)
	show_choices(choices)


func show_choices(arr):
	# given an array of scenes, spawn all scenes in a circle
	var rngi = len(arr)
	var theta = PI/2    # pi/2 to start from the top
	
	for i in range(rngi):
		var inst = arr[i].instance()
		$Placement.add_child(inst)
		
		var x = centerx + centerx * cos(theta)
		var y = centery - centery * sin(theta)
		x = x - inst.rect_size.x/2.0
		y = y - inst.rect_size.y/2.0
		theta += PI / (rngi/2.0)
		
		inst.rect_position = Vector2(x, y)
		inst.connect("hover", self, "_on_hover")
		inst.connect("choose", self, "_on_choose")


func clear():
	for x in $Placement.get_children():
		x.queue_free()
	#$Placement.visible = false
	$Info.visible = false
	$Info/Title.text = "LEVEL UP"
	$Info/Description.text = ""


func rand_choice(arr, amt):
	# randomly choose {amt} items from {arr}
	if amt > len(arr):  # can't choose more items than exist
		return arr
	
	else:
		var choices = []
		while len(choices) < amt:
			var tmp = arr[randi() % len(arr)]
			if not (tmp in choices):
				choices.append(tmp)
		
		return choices


func _on_choose():
	clear()
	level_signals -= 1  # reduce level queue by 1
	
	if level_signals:   # check if any levels still queued, end level up if not
		generate()
	else:
		is_leveling = false
		PauseManager.pause(false)


func _on_hover(title, desc):
	$Info/Title.text = title
	$Info/Description.text = desc

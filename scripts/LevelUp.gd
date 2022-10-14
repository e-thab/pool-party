extends CanvasLayer


export(Array, PackedScene) var powerups_t1  # most common
export(Array, PackedScene) var powerups_t2
export(Array, PackedScene) var powerups_t3  # least common
#var powerup_levels = {}  # dictionary to track powerup levels
var powerups = {}

onready var centerx = $Placement.rect_size.x/2.0
onready var centery = $Placement.rect_size.y/2.0
onready var player = Game.get_player()
var level_signals = 0
var is_leveling = false


# Called when the node enters the scene tree for the first time.
func _ready():
	# connect signal for leveling up
	player.connect("level_up", self, "_on_level_up")
	
	# populate powerups dictionary with PackedScene ID and powerup level
	for p in powerups_t1 + powerups_t2 + powerups_t3:
		var inst = p.instance()
		powerups[inst.title] = [p, 0]  # id, level
		inst.queue_free()


func _on_level_up():
	queue_level_up()

# queue allows adding multiple levels at once without everything happening simultaneously
func queue_level_up():
	level_signals += 1
	if not is_leveling:
		is_leveling = true
		PauseManager.pause(true)
		generate()


func generate():
	$Placement.visible = true
	$Info.visible = true
	
	var tiers = [0, 0, 0]  # how many powerups in each tier that will be generated
	for _i in range(player.lvl_choices):  # weighting
		var rnd = randf()
		if rnd >= 0.6:     # 40% chance to get tier 1
			tiers[0] += 1
		elif rnd >= 0.25:  # 35% chance to get tier 2
			tiers[1] += 1
		else:
			tiers[2] += 1  # 25% chance to get tier 3
	
	# problem. if more choices are generated in one tier than exist in that tier
	# e.g. lvl_choices = 4, and tiers = [1, 0, 3] but there are only 2 tier 3 to choose from
	# then only 3 choices would be generated, even though 4 total choices do exist
	
	# correcting
	if tiers[2] > len(powerups_t3):              # if you should have e.g. 4 tier 3s, but only 2 exist,
		tiers[1] += tiers[2] - len(powerups_t3)  # add 2 tier 2s
		
	if tiers[1] > len(powerups_t2):              # same idea for next tier. filter down
		tiers[0] += tiers[1] - len(powerups_t2)  # if tiers[0] is higher now, you just miss out
	
	var choices = []  # populate choices with weighted and corrected tier quantities
	if tiers[0]:
		choices += rand_choice(powerups_t1, tiers[0])
	if tiers[1]:
		choices += rand_choice(powerups_t2, tiers[1])
	if tiers[2]:
		choices += rand_choice(powerups_t3, tiers[2])
	#print('tier 1 choices: ', tiers[0])
	#print('tier 2 choices: ', tiers[1])
	#print('tier 3 choices: ', tiers[2])
	
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
	
	$Placement.visible = false
	$Info.visible = false
	$Info/Title.text = "LEVEL UP"
	$Info/Description.text = "Good job :^)"


func rand_choice(arr, amt):
	# randomly choose {amt} items from {arr}
	if len(arr) == 0:
		return
	if amt > len(arr):  # can't choose more items than exist
		return arr
	
	else:
		var choices = []
		while len(choices) < amt:
			var tmp = arr[randi() % len(arr)]
			if not (tmp in choices):
				choices.append(tmp)
		
		return choices


func remove_powerup(pscene):
	if pscene in powerups_t1:
		powerups_t1.erase(pscene)


func _on_choose(title):
	powerups[title][1] += 1       # inc powerup level by 1
	if powerups[title][1] >= 10:  # if powerup level >= 10, remove from pool
		remove_powerup(powerups[title])
		print('removing ', title)
	print(title, ': ', powerups[title])

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

extends Node


# Declare member variables here. Examples:
export(Resource) var crosshair
#export(PackedScene) var pickup_temp
export(bool) var debug

var kills = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#Engine.set_target_fps(Engine.get_iterations_per_second())
	#print("setting fps at " + str(Engine.get_iterations_per_second()))
	$LevelUp.connect("pause", $PauseManager, "_on_pause")
	$HUD.connect("pause", $PauseManager, "_on_pause")
	
	Input.set_custom_mouse_cursor(crosshair, 0, crosshair.get_size()/2)
	randomize()
	
	#temp_pickup_spawn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if debug:
		if Input.is_action_just_pressed("debug_1"):
			$DebugHUD.visible = !$DebugHUD.visible
		
		if Input.is_action_pressed("debug_speed+"):
			Engine.time_scale = 3
		elif Input.is_action_pressed("debug_speed-"):
			Engine.time_scale = 0.33
		else:
			Engine.time_scale = $DebugHUD.target_time_scale


#func temp_pickup_spawn():
#	for x in range(-1000, 1000, 50):
#		for y in range(-1000, 1000, 50):
#			var t = pickup_temp.instance()
#			t.position = Vector2(x, y)
#			add_child(t)


func _on_enemy_death():
	kills += 1
	$HUD/KillsLabel.text = "KILLS: " + str(kills)

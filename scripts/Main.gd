extends Node


# Declare member variables here. Examples:
export(Resource) var crosshair
export(PackedScene) var zombie

onready var player = $Player1
var kills = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#Engine.set_target_fps(Engine.get_iterations_per_second())
	#print("setting fps at " + str(Engine.get_iterations_per_second()))
	
	# fnny
	#Engine.time_scale = 5
	
	Input.set_custom_mouse_cursor(crosshair, 0, Vector2(16, 16))
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_MobTimer_timeout():
	# spawn a zombie at a random point on MobPath
	var mob = zombie.instance()
	var spawn_loc = $MobPath/MobSpawnLocation
	spawn_loc.offset = randi()
	mob.position = player.position + spawn_loc.position
	
	# connect death signal from zombie script
	mob.connect("enemy_death", self, "_on_enemy_death")
	
	# place in scene
	add_child(mob)


func _on_enemy_death():
	kills += 1
	$HUD/KillsLabel.text = "KILLS: " + str(kills)

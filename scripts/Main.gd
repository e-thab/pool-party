extends Node


# Declare member variables here. Examples:
var rng = RandomNumberGenerator.new()

export(Resource) var crosshair
export(PackedScene) var zombie

onready var player = $Player1


# Called when the node enters the scene tree for the first time.
func _ready():
	#Engine.set_target_fps(Engine.get_iterations_per_second())
	#print("setting fps at " + str(Engine.get_iterations_per_second()))
	
	# fnny
	#Engine.time_scale = 5
	
	Input.set_custom_mouse_cursor(crosshair, 0, Vector2(16, 16))
	rng.randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_MobTimer_timeout():
	# spawn a zombie at a random point on MobPath
	var mob = zombie.instance()
	var spawn_loc = $MobPath/MobSpawnLocation
	spawn_loc.offset = rng.randi()
	mob.position = player.position + spawn_loc.position
	add_child(mob)

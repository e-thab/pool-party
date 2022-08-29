extends Node


# Declare member variables here. Examples:
var rng = RandomNumberGenerator.new()

export(Resource) var crosshair
export(PackedScene) var zombie

onready var player = $Player1


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	Input.set_custom_mouse_cursor(crosshair, 0, Vector2(16, 16))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_MobTimer_timeout():
	var mob = zombie.instance()
	var spawn_loc = $MobPath/MobSpawnLocation
	spawn_loc.offset = randi()
	mob.position = player.position + spawn_loc.position
	#print("spawning at " + str(mob.global_position))
	add_child(mob)

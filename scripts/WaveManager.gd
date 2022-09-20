extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(PackedScene) var zombie
export(bool) var spawn_enemies = true

onready var root = get_tree().get_root()
onready var main = root.get_node("Main")
onready var player  = get_tree().get_nodes_in_group("player")[0]

# Called when the node enters the scene tree for the first time.
func _ready():
	if not spawn_enemies:
		$MobTimer.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MobTimer_timeout():
	# spawn a zombie at a random point on MobPath
	var mob = zombie.instance()
	var spawn_loc = $MobPath/MobSpawnLocation
	spawn_loc.offset = randi()
	mob.position = player.position + spawn_loc.position
	
	# connect death signal from zombie script to main node
	mob.connect("enemy_death", main, "_on_enemy_death")
	
	# place in game
	root.add_child(mob)

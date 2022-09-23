extends Node


export(PackedScene) var zombie
export(bool) var spawn_enemies = true

onready var root = get_tree().get_root()
onready var main = root.get_node("Main")
onready var player = get_tree().get_nodes_in_group("player")[0]

var wave_kills = [0,  10,  15,  20,  25,  30]
var wave_speed = [0, 1.0, 0.9, 0.8, 0.7, 0.6]
var wave_mobs  = [0,  20,  30,  40,  50,  60]

var wave = 1
var max_wave = len(wave_kills) - 1

var kill_count = 0
var mob_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$MobTimer.wait_time = wave_speed[wave]
	update_wave_bar()
	
	if not spawn_enemies:
		$MobTimer.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawn_mob(mob):
	# spawn a zombie at a random point on MobPath
	var spawn_loc = $MobPath/MobSpawnLocation
	spawn_loc.offset = randi()
	mob.position = player.position + spawn_loc.position
	
	# connect death signal from zombie script to this and main node
	mob.connect("enemy_death", self, "_on_enemy_death")
	mob.connect("enemy_death", main, "_on_enemy_death")
	# place in game
	root.add_child(mob)
	
	mob_count += 1


func new_wave():
	if wave < max_wave:
		wave += 1
		kill_count = 0
		$MobTimer.wait_time = wave_speed[wave]
	else:
		$MobTimer.wait_time = 0.1


func update_wave_bar():
	if wave >= max_wave:
		$HUD/WaveBar.max_value = 1
		$HUD/WaveBar.value = 1
		$HUD/WaveBar/Wave.text = "WAVE MAX"
	else:
		$HUD/WaveBar.max_value = wave_kills[wave]
		$HUD/WaveBar.value = kill_count
		$HUD/WaveBar/Wave.text = "WAVE " + str(wave)


func _on_MobTimer_timeout():
	if mob_count < wave_mobs[wave]:
		spawn_mob(zombie.instance())


func _on_enemy_death():
	kill_count += 1
	mob_count -= 1
	if kill_count >= wave_kills[wave]:
		new_wave()
	
	if wave <= max_wave:
		update_wave_bar()
	
	print(mob_count)
	

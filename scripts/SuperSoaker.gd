extends Sprite

signal reload(time)
signal stop_reload()
signal update_ammo(amt, maxm)

# Declare member variables here. Examples:
export(PackedScene) var projectile
onready var root = get_tree().get_root()
onready var player = get_tree().get_nodes_in_group("player")[0]

var base_dmg = 1.0
var base_rate = 0.4
var base_reload = 1.0
var base_spd = 200.0
var base_ammo = 12
var can_fire = true
var reloading = false

var max_ammo
var ammo

# Called when the node enters the scene tree for the first time.
func _ready():
	max_ammo = base_ammo + player.ammo_mod
	ammo = max_ammo
	update_ammo()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("primary_fire") and can_fire:
		shoot()
	elif Input.is_action_just_pressed("reload") and not reloading and not ammo == max_ammo:
		reload()
	
	flip_v = global_rotation < (-PI/2) or global_rotation > (PI/2) # use abs() for easier comparison


func shoot():
	if reloading:
		stop_reload()
	
	can_fire = false
	$ShotTimer.wait_time = base_rate * (100.0 / player.fire_rate)
	$ShotTimer.start()
	
	var proj_inst = projectile.instance()
	root.add_child(proj_inst)
	proj_inst.position = $ShotOrigin.global_position
	proj_inst.rotation = $ShotOrigin.global_rotation
	proj_inst.set_dmg(base_dmg * (player.damage / 100.0))
	proj_inst.set_spd(base_spd * (player.shot_speed / 100.0))
	
	ammo -= 1
	update_ammo()
	if ammo <= 0:
		reload()


func update_ammo():
	emit_signal("update_ammo", ammo, max_ammo)


func reload():
	reloading = true
	emit_signal("reload", base_reload * (100.0 / player.reload_speed))


func stop_reload():
	reloading = false
	emit_signal("stop_reload")
	update_ammo()


func _on_ShotTimer_timeout():
	if ammo > 0:
		can_fire = true


func _on_reload_done():
	ammo = max_ammo
	update_ammo()
	reloading = false
	can_fire = $ShotTimer.time_left == 0

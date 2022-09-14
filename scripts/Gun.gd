extends Node2D


# Declare member variables here. Examples:
export(PackedScene) var projectile
onready var root = get_tree().get_root()
onready var player = get_tree().get_nodes_in_group("player")[0]

var base_dmg = 1.0       # literal damage value
var base_rate = 100.0    # fire rate, percentage of 1 sec
var base_reload = 100.0  # reload rate, percentage of 1 sec
var base_spd = 100.0     # projectile speed, arbitrary for now
var base_ammo = 10       # literal number of shots per mag
var base_shot_count = 1  # literal number of projectiles per shot
var base_spread = 10.0   # arc spread in degrees for guns w/ multi shot
var multi_shot = false   # flag for guns with multiple shots by default

var max_ammo
var ammo
var can_fire = true
var reloading = false

# Called when the node enters the scene tree for the first time.
func _ready():
	max_ammo = base_ammo + player.ammo_mod # this ready 'overrides' instance ready
	ammo = max_ammo
	update_ammo()
	
	# set reload UI as top level so it doesn't follow weapon transform position
	$UI.set_as_toplevel(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("primary_fire") and can_fire:
		if reloading:
			stop_reload()
		shoot()
	elif Input.is_action_just_pressed("reload") and not reloading and not ammo == max_ammo:
		reload()
	
	if reloading:
		display_reload() # show reload timer indicator
	
	$Sprite.flip_v = global_rotation < (-PI/2) or global_rotation > (PI/2) # use abs() for easier comparison


func _physics_process(_delta):
	$UI.position = player.position


func shoot():
	can_fire = false
	$ShotTimer.wait_time = (base_rate / 100.0) * (100.0 / player.fire_rate)
	$ShotTimer.start()
	
	if multi_shot or player.shot_count > 0:
		var shot_count = base_shot_count + player.shot_count
		var spread = max(base_spread, player.shot_spread)
		var theta = $ShotOrigin.global_rotation_degrees + spread/2
		var inc = spread / (shot_count - 1)
		
		for i in range(shot_count):
			instance_projectile(deg2rad(theta))
			theta -= inc
	else:
		instance_projectile($ShotOrigin.global_rotation)
	
	ammo -= 1
	update_ammo()
	if ammo <= 0:
		reload()


func instance_projectile(rot):
	var proj_inst = projectile.instance()
	root.add_child(proj_inst)
	proj_inst.position = $ShotOrigin.global_position
	proj_inst.rotation = rot
	proj_inst.set_dmg(base_dmg * (player.damage / 100.0))
	proj_inst.set_spd(base_spd * (player.shot_speed / 100.0))


func update_ammo():
	$UI/AmmoBar.max_value = max_ammo
	$UI/AmmoBar.value = ammo
	$UI/AmmoLabel.text = str(ammo) + "/" + str(max_ammo)


func reload():
	reloading = true
	$ReloadTimer.wait_time = (base_reload / 100.0) * (100.0 / player.reload_speed)
	$UI/AmmoBar.max_value = $ReloadTimer.wait_time
	$ReloadTimer.start()


func display_reload():
	$UI/AmmoBar.value = $ReloadTimer.wait_time - $ReloadTimer.time_left


func stop_reload():
	reloading = false
	$ReloadTimer.stop()
	update_ammo()


func _on_ShotTimer_timeout():
	can_fire = ammo > 0


func _on_ReloadTimer_timeout():
	ammo = max_ammo
	update_ammo()
	reloading = false
	can_fire = $ShotTimer.time_left == 0

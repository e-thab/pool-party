extends Sprite


# Declare member variables here. Examples:
export(PackedScene) var projectile
onready var root = get_tree().get_root()
onready var player = get_tree().get_nodes_in_group("player")[0]

var base_dmg = 1.0
var base_rate = 0.4
var base_reload = 1.0 
var base_spd = 250.0
var base_ammo = 12
var can_fire = true
var reloading = false

var max_ammo
var ammo

# Called when the node enters the scene tree for the first time.
func _ready():
	max_ammo = base_ammo + player.max_ammo
	ammo = max_ammo
	update_ammo()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("primary_fire") and can_fire:
		shoot()
	elif Input.is_action_just_pressed("reload"):
		reload()
	
	if reloading:
		display_reload() # show reload timer indicator
	
	flip_v = global_rotation < (-PI/2) or global_rotation > (PI/2)


func shoot():
	if reloading:
		stop_reload()
	
	can_fire = false
	$ShotTimer.wait_time = base_rate * (player.fire_rate / 100.0) # make this inverse
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
	$Canvas/AmmoLabel.text = str(ammo) + "/" + str(max_ammo)


func reload():
	reloading = true
	$Canvas/ReloadProgress.visible = true
	$ReloadTimer.wait_time = base_reload * (player.reload_speed / 100.0)
	$ReloadTimer.start()


func display_reload():
	$Canvas/ReloadProgress.max_value = $ReloadTimer.wait_time
	$Canvas/ReloadProgress.value = $ReloadTimer.wait_time - $ReloadTimer.time_left


func stop_reload():
	reloading = false
	$ReloadTimer.stop()
	$Canvas/ReloadProgress.visible = false


func _on_ShotTimer_timeout():
	if ammo > 0:
		can_fire = true


func _on_ReloadTimer_timeout():
	ammo = max_ammo
	update_ammo()
	$Canvas/ReloadProgress.visible = false
	reloading = false
	can_fire = true

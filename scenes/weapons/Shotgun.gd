extends "res://scripts/Gun.gd"


func _ready():
	base_dmg = 0.6
	base_rate = 0.4
	base_reload = 1.2
	base_spd = 200.0
	base_ammo = 6


func shoot():
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

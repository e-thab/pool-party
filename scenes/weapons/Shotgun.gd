extends "res://scripts/Gun.gd"

func _ready():
	base_dmg = 0.8
	base_rate = 100.0
	base_reload = 100.0
	base_spd = 200.0
	base_ammo = 6
	
	base_shot_count = 4
	base_spread = 40
	multi_shot = true


#func shoot():
#	can_fire = false
#	$ShotTimer.wait_time = (base_rate / 100.0) * (100.0 / player.fire_rate)
#	$ShotTimer.start()
#
#	var shot_count = 8
#	var spread = 60
#	var f = spread / (shot_count - 1)
#	var theta = $ShotOrigin.global_rotation_degrees + spread/2
#
#	for i in range(shot_count):
#		var proj_inst = projectile.instance()
#		root.add_child(proj_inst)
#		proj_inst.position = $ShotOrigin.global_position
#		proj_inst.rotation = deg2rad(theta)
#		proj_inst.set_dmg(base_dmg * (player.damage / 100.0))
#		proj_inst.set_spd(base_spd * (player.shot_speed / 100.0))
#		theta -= f
#
#	ammo -= 1
#	update_ammo()
#	if ammo <= 0:
#		reload()

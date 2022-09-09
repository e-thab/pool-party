extends KinematicBody2D


#signal stats_changed(stat, val)
signal reload_done

export(PackedScene) var weapon_type

var max_health = 10.0
var speed = 100.0 # percentage
var ammo_mod = 0 # int, adds to weapon max ammo
# variables below are percentages that modify base weapon stats
var damage = 100.0
var fire_rate = 100.0
var shot_speed = 100.0
var reload_speed = 100.0

onready var screen_size  = get_viewport_rect().size
onready var tile = $TileSpriteBG

#var moving_left = false
var reloading = false
var being_hurt = false
var health = 0.0
var gun

var dir = Vector2.ZERO
var mod_friction = 0.18


func _ready():
	# create exported weapon type instance
	gun = weapon_type.instance()
	$GunPosition.add_child(gun)
	gun.connect("reload", self, "_on_reload")
	gun.connect("update_ammo", self, "_on_update_ammo")
	gun.connect("stop_reload", self, "_on_stop_reload")
	connect("reload_done", gun, "_on_reload_done")
	
	# set health
	health = max_health
	update_health_bar()


func _process(_delta):
	if reloading:
		display_reload() # show reload timer indicator


func _physics_process(delta):
	# get movement input
	dir = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	
	if dir.length() > 0:
		dir = dir.normalized() #* speed * Stats.SPEED_MODIFIER
		if not being_hurt: $AnimatedSprite.play("run")
	else:
		if not being_hurt: $AnimatedSprite.play("idle")
	
	# apply movement
	var _collide = move_and_collide(dir * speed * Stats.SPEED_MODIFIER * delta)
	#move_and_slide(dir * speed * Stats.SPEED_MODIFIER)
	
	# face moving direction and keep state when no direction
#	if dir.x < 0:
#		moving_left = true
#	elif dir.x > 0:
#		moving_left = false
#	$AnimatedSprite.flip_h = moving_left
	
	# face moving direction, prioritizing aim direction when stopped
	if dir.x == 0:
		$AnimatedSprite.flip_h = abs($GunPosition.position.angle()) > PI/2
	else:
		$AnimatedSprite.flip_h = dir.x <= 0
	
	# offset background tile to make it look constant
	tile.region_rect = Rect2(Vector2(position.x, position.y), screen_size*2)


func hurt(n):
	# check for on-hit invincibility (duration of hurt animation)
	if not being_hurt:
		health -= n
		being_hurt = true
		$AnimatedSprite.play("hurt")
		update_health_bar()


func heal(n):
	health += n
	update_health_bar()


func update_health_bar():
	$HealthBar.max_value = max_health
	$HealthBar.value = health
#	emit_signal("stats_changed", Stats.HEALTH, health)
#	print("player hurt. hp = " + str(health))


func display_reload():
	$AmmoBar.value = $ReloadTimer.wait_time - $ReloadTimer.time_left


func _on_PlayerSprite_animation_finished():
	if $AnimatedSprite.animation == "hurt":
		being_hurt = false # make this (invincibility duration) more controllable
		$AnimatedSprite.stop()


func _on_reload(time):
	reloading = true
	$AmmoBar.max_value = $ReloadTimer.wait_time
	$ReloadTimer.wait_time = time
	$ReloadTimer.start()


func _on_update_ammo(amt, maxm):
	$AmmoBar.max_value = maxm
	$AmmoBar.value = amt
	$AmmoLabel.text = str(amt) + "/" + str(maxm)


func _on_ReloadTimer_timeout():
	reloading = false
	emit_signal("reload_done")


func _on_stop_reload():
	reloading = false
	$ReloadTimer.stop()

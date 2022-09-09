extends KinematicBody2D


#signal stats_changed(stat, val)

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
var being_hurt = false
var health = 0.0
var gun

var dir = Vector2.ZERO
var mod_friction = 0.18


func _ready():
	# create exported weapon type instance
	gun = weapon_type.instance()
	$GunPosition.add_child(gun)
	
	# set health
	health = max_health
	update_health_bar()


#func _process(_delta):
#	pass


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


func _on_PlayerSprite_animation_finished():
	if $AnimatedSprite.animation == "hurt":
		being_hurt = false # make this (invincibility duration) more controllable
		$AnimatedSprite.stop()

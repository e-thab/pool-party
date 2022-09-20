extends KinematicBody2D


export(PackedScene) var weapon_type

var pickup_dist = 100.0
var max_health = 10.0
var speed = 100.0        # percentage
var ammo_mod = 0         # adds to weapon max ammo
var xp = 0
var lvl = 1

# modify base weapon stats
var damage = 100.0       # percentage
var fire_rate = 100.0    # percentage
var reload_speed = 100.0 # percentage
var shot_speed = 100.0   # percentage
var shot_count = 0       # int, adds to base count
var shot_spread = 20     # angle of shot spread, does not add
var pierce = 0           # number of enemies to pierce

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
	equip_weapon(weapon_type)
	
	# set health
	health = max_health
	update_health_bar()
	update_xp_bar()


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


func add_xp(n):
	xp += int(n)
	var new_lvl = Stats.xp2lvl(xp)
	
	for _i in range(lvl, new_lvl):
		level_up()
	
	update_xp_bar()


func level_up():
	if lvl < len(Stats.lvl_incs):
		#print('level up')
		lvl += 1


func update_xp_bar():
	if lvl >= len(Stats.lvl_incs):
		$XPHUD/XPBar.max_value = 1
		$XPHUD/XPBar.value = 1
		$XPHUD/XPBar/Level.text = "LVL MAX"
	else:
		$XPHUD/XPBar.max_value = Stats.lvl_incs[lvl+1]
		$XPHUD/XPBar.value = xp - Stats.lvl_sums[lvl]
		$XPHUD/XPBar/Level.text = "LVL " + str(lvl)
	
#	print('max_value =', Stats.lvl_incs[lvl+1])
#	print('value =', xp - Stats.lvl_sums[lvl])


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


func equip_weapon(weapon):
	gun = weapon.instance()
	$GunPosition.add_child(gun)


func set_stats(stat, val):
	# match statement for changing stats, calls necessary functions & guarantees proper type
	match stat:
		Stats.PICKUP_DIST:
			pickup_dist = val
		
		Stats.MAX_HEALTH:
			max_health = val
			update_health_bar()
		
		Stats.HEALTH:
			health = val
			update_health_bar()
		
		Stats.SPEED:
			speed = val
		
		Stats.AMMO_MOD:
			ammo_mod = val
		
		Stats.XP:
#			xp = int(val)
			add_xp(int(val))
		
		Stats.LVL:
			lvl = int(val)
			level_up()
		
		Stats.DAMAGE:
			damage = val
		
		Stats.FIRE_RATE:
			fire_rate = val
		
		Stats.RELOAD_SPEED:
			reload_speed = val
		
		Stats.SHOT_SPEED:
			shot_speed = val
		
		Stats.SHOT_COUNT:
			shot_count = int(val)
		
		Stats.SHOT_SPREAD:
			shot_spread = int(val)
		
		Stats.PIERCE:
			pierce = int(val)


func _on_PlayerSprite_animation_finished():
	if $AnimatedSprite.animation == "hurt":
		being_hurt = false # make this (invincibility duration) more controllable
		$AnimatedSprite.stop()

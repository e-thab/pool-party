extends KinematicBody2D


signal stats_changed
signal level_up

export(PackedScene) var weapon_type
export(Color) var hand_color

# literal values
var pickup_dist = 100.0  # literal distance in units but can be treated as percentage
var regen_amt = 1.0      # how much health to regen
var regen_time = 5.0     # time to regen 
var lvl_choices = 4      # number of powerup choices on level
var max_health = 100.0   

# percentages
var speed = 100.0
var xp_gain = 100.0
var crit_chance = 5.0

# modify base weapon stats
var damage = 100.0       # percentage
var fire_rate = 100.0    # percentage
var reload_speed = 100.0 # percentage
var shot_speed = 100.0   # percentage
var shot_size = 100.0    # percentage
var extra_ammo = 0       # int literal, adds to weapon max ammo
var extra_shots = 0      # int literal, adds to base weapon shots
var shot_spread = 20     # angle of shot spread in degrees
var pierce = 0           # number of enemies to pierce

# base player stats so that percentage modifiers don't compound undesirably
#onready var base_pickup_dist = pickup_dist
#onready var base_max_health = max_health
#onready var base_speed = speed
#onready var base_xp_gain = xp_gain
#onready var base_damage = damage
#onready var base_fire_rate = fire_rate
#onready var base_reload_speed = reload_speed
#onready var base_shot_speed = shot_speed

onready var screen_size  = get_viewport_rect().size
onready var tile = $TileSpriteBG
onready var cam = $PlayerCamera

# misc. trackers
var xp = 0
var xp_remainder = 0
var lvl = 1
var being_hurt = false
var health
var gun
var dir = Vector2.ZERO
var mod_friction = 0.18


func _ready():
	# create exported weapon type instance
	equip_weapon(weapon_type)
	
	# set health / regen
	health = max_health
	$RegenTimer.wait_time = regen_time
	$RegenTimer.start()
	
	# set progress bars
	update_health_bar()
	update_xp_bar()


func _process(_delta):
	# the use of just_released probably makes this bad for non-scroll bindings,
	# but scroll requires it. may try an or with action_pressed
	if Input.is_action_just_released("zoom_in"):
		var zoom = max(cam.zoom.x - 0.02, 0.25)
		cam.zoom = Vector2(zoom, zoom)
		
	elif Input.is_action_just_released("zoom_out"):
		var zoom = min(cam.zoom.x + 0.02, 1)
		cam.zoom = Vector2(zoom, zoom)
		
	elif Input.is_action_just_pressed("zoom_reset"):
		cam.zoom = Vector2(1, 1)


func _physics_process(delta):
	# get movement input
	dir = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	
	if dir.length() > 0:
		dir = dir.normalized() #* speed * Stats.SPEED_MODIFIER
		if not being_hurt: $AnimatedSprite.play("walk")
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
	var to_add = n * (xp_gain / 100.0)  # exact amount of xp to be added
	xp = max(0, xp + int(to_add))       # only add integer portion, cap minimum at 0
	xp_remainder += fmod(to_add, 1)     # get decimal portion for safe keeping
	xp = max(xp, Stats.lvl_sums[lvl])        # cap xp min
	xp_remainder = max(0, xp_remainder)
	# xp_remainder allows for something like 120% xp gain to actually make a difference
	# even though xp is an integer and will often only be added 1 at a time
	
	if xp_remainder >= 1:                     # if remainder is 1 or more, it should be added
		xp += int(xp_remainder)               # add integer portion
		xp_remainder = fmod(xp_remainder, 1)  # safe keeping
	#print(xp_remainder)
	
	var new_lvl = Stats.xp2lvl(xp) # find target level at current total xp
	
	for _i in range(lvl, new_lvl): # for every level between current and target
		level_up()
	
	update_xp_bar()
	emit_signal("stats_changed", Stats.XP)


func level_up():
	if lvl < len(Stats.lvl_incs) - 1:
		lvl += 1
		emit_signal("level_up")
		emit_signal("stats_changed", Stats.LVL)
	update_xp_bar()


func update_xp_bar():
	if lvl >= len(Stats.lvl_incs) - 1:
		$PlayerHUD/XPBar.max_value = 1
		$PlayerHUD/XPBar.value = 1
		$PlayerHUD/XPBar/Level.text = "LVL MAX"
	else:
		$PlayerHUD/XPBar.max_value = Stats.lvl_incs[lvl+1]
		$PlayerHUD/XPBar.value = xp - Stats.lvl_sums[lvl]
		$PlayerHUD/XPBar/Level.text = "LVL " + str(lvl)


func hurt(n):
	# check for on-hit invincibility (duration of hurt animation)
	if not being_hurt:
		health -= n
		being_hurt = true
		$AnimatedSprite.play("hurt")
		update_health_bar()
		emit_signal("stats_changed", Stats.HEALTH)


func heal(n):
	health = min(max_health, health + n)  # prevent healing past full
	update_health_bar()
	emit_signal("stats_changed", Stats.HEALTH)


func update_health_bar():
	$HealthBar.max_value = max_health
	$HealthBar.value = health


func equip_weapon(weapon):
	gun = weapon.instance()
	$GunPosition.add_child(gun)


func add_stats(stat, val):
	set_stats(stat, val, true)


func set_stats(stat, val, add=false):
	# match statement for changing stats, calls necessary functions & guarantees proper type
	# stat is the type of stat to set
	# if add: value is added onto current stat, otherwise directly set
	# percentage may not be necessary. could just always assume base = 100 even for characters with higher base
	add = bool(add)
	var addb = int(add)
	
	match stat:
		Stats.PICKUP_DIST:
			pickup_dist = pickup_dist*addb + val
		
		Stats.MAX_HEALTH:
			var ratio = health / max_health
			max_health = max_health*addb + val
			set_stats(Stats.HEALTH, max_health * ratio)
			#update_health_bar()
		
		Stats.HEALTH:
			if add:
				if val >= 0:
					heal(val)
				else:
					hurt(abs(val))
			else:
				health = int(val)
				update_health_bar()
		
		Stats.REGEN_AMT:
			regen_amt = regen_amt*addb + val
		
		Stats.REGEN_TIME:
			regen_time = regen_time*addb + val
			$RegenTimer.wait_time = regen_time
		
		Stats.SPEED:
			speed = speed*addb + val
		
		Stats.EXTRA_AMMO:
			extra_ammo = extra_ammo*addb + int(val)
		
		Stats.XP:
			if add:
				add_xp(int(val))
			else:
				xp = int(val)
		
		Stats.XP_GAIN:
			xp_gain = xp_gain*addb + val
		
		Stats.LVL:
			var new_lvl = lvl*addb + int(val)
			
			for _i in range(lvl, new_lvl):
				level_up()
			xp = Stats.lvl_sums[lvl]
		
		Stats.LVL_CHOICES:
			lvl_choices = lvl_choices*addb + int(val)
		
		Stats.DAMAGE:
			damage = damage*addb + val
		
		Stats.FIRE_RATE:
			fire_rate = fire_rate*addb + val
		
		Stats.RELOAD_SPEED:
			reload_speed = reload_speed*addb + val
		
		Stats.SHOT_SPEED:
			shot_speed = shot_speed*addb + val
		
		Stats.SHOT_SIZE:
			shot_size = shot_size*addb + val  # doesn't actually do anything yet
		
		Stats.EXTRA_SHOTS:
			extra_shots = extra_shots*addb + int(val)
		
		Stats.SHOT_SPREAD:
			shot_spread = shot_spread*addb + int(val)
		
		Stats.PIERCE:
			pierce = max(0, pierce*addb + int(val))
		
		Stats.CRIT_CHANCE:
			crit_chance = max(0, crit_chance*addb + int(val))
	emit_signal("stats_changed", stat)


func _on_PlayerSprite_animation_finished():
	if $AnimatedSprite.animation == "hurt":
		being_hurt = false # make this (invincibility duration) more controllable
		#$AnimatedSprite.stop()


func _on_RegenTimer_timeout():
	heal(regen_amt)

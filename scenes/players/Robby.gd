extends "res://scenes/players/parent/Player.gd"


func _init():
	pickup_dist = 100.0  # distance in units
	max_health = 100.0
	health = max_health
	speed = 100.0        # percentage
	xp = 0
	xp_gain = 100.0      # percentage
	lvl = 1
	lvl_choices = 3
	crit_chance = 5.0

	# modify base weapon stats
	extra_ammo = 0       # adds to weapon max ammo
	damage = 100.0       # percentage
	fire_rate = 100.0    # percentage
	reload_speed = 100.0 # percentage
	shot_speed = 100.0   # percentage
	shot_size = 100.0    # percentage
	extra_shots = 0      # int, adds to base count
	shot_spread = 20     # angle of shot spread, does not add
	pierce = 0           # number of enemies to pierce

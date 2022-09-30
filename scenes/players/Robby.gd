extends "res://scenes/players/parent/Player.gd"


func _init():
	pickup_dist = 100.0  # distance in units
	max_health = 100.0
	speed = 100.0        # percentage
	ammo_mod = 0         # adds to weapon max ammo
	xp = 0
	lvl = 1

	# modify base weapon stats
	damage = 100.0       # percentage
	fire_rate = 100.0    # percentage
	reload_speed = 100.0 # percentage
	shot_speed = 100.0   # percentage
	shot_count = 0       # int, adds to base count
	shot_spread = 20     # angle of shot spread, does not add
	pierce = 0           # number of enemies to pierce

extends Node

# AutoLoad stats
const SPEED_MODIFIER = 2

enum {
	PICKUP_DIST,
	MAX_HEALTH,
	HEALTH,
	REGEN_AMT,
	REGEN_TIME,
	SPEED,
	EXTRA_AMMO,
	XP,
	XP_GAIN,
	LVL,
	LVL_CHOICES,
	DAMAGE,
	FIRE_RATE,
	RELOAD_SPEED,
	SHOT_SPEED,
	SHOT_SIZE,
	EXTRA_SHOTS,
	SHOT_SPREAD,
	PIERCE,
	CRIT_CHANCE}

	   # Level: 0, 1, 2, 3,  4,  5,  6,  7,   8,   9,  10
var lvl_incs = [0, 0, 4, 5,  8, 13, 20, 29,  40,  53,  68]
var lvl_sums = [0, 0, 4, 9, 17, 30, 50, 79, 119, 172, 240]

func xp2lvl(n):
	if n >= lvl_sums[-1]:
		return lvl_sums[-1]
	
	for i in range(len(lvl_sums)):
		if lvl_sums[i] == n:
			return i
		elif lvl_sums[i] > n:
			return i - 1

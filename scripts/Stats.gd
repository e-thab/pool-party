extends Node

# AutoLoad stats
const SPEED_MODIFIER = 2

enum {
	PICKUP_DIST,
	MAX_HEALTH,
	REGEN_AMT,
	REGEN_TIME,
	HEALTH,
	SPEED,
	AMMO_MOD,
	XP,
	LVL,
	DAMAGE,
	FIRE_RATE,
	RELOAD_SPEED,
	SHOT_SPEED,
	SHOT_COUNT,
	SHOT_SPREAD,
	PIERCE}

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

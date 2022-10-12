extends CanvasLayer


# Declare member variables here. Examples:
onready var player = Game.get_player()
onready var controls = [
		$Container/FPS, $Container/TimeScale, $Container/MaxHP, $Container/HP,
		$Container/RegenAmt, $Container/RegenTime, $Container/XP,$Container/XPGain,
		$Container/Level, $Container/LevelChoices, $Container/PickupDistance,
		$Container/Speed, $Container/Dmg,  $Container/Ammo, $Container/FireRate,
		$Container/ReloadSpeed, $Container/ShotSpeed, $Container/ShotSize,
		$Container/ExtraShots, $Container/ShotSpread, $Container/Pierce,
		$Container/CritChance
		]

onready var labels = {
	Stats.PICKUP_DIST : $Container/PickupDistance/Label,
	Stats.MAX_HEALTH : $Container/MaxHP/Label,
	Stats.HEALTH : $Container/HP/Label,
	Stats.REGEN_AMT : $Container/RegenAmt/Label,
	Stats.REGEN_TIME : $Container/RegenTime/Label,
	Stats.SPEED : $Container/Speed/Label,
	Stats.EXTRA_AMMO : $Container/Ammo/Label,
	Stats.XP : $Container/XP/Label,
	Stats.XP_GAIN : $Container/XPGain/Label,
	Stats.LVL : $Container/Level/Label,
	Stats.LVL_CHOICES : $Container/LevelChoices/Label,
	Stats.DAMAGE : $Container/Dmg/Label,
	Stats.FIRE_RATE : $Container/FireRate/Label,
	Stats.RELOAD_SPEED : $Container/ReloadSpeed/Label,
	Stats.SHOT_SPEED : $Container/ShotSpeed/Label,
	Stats.SHOT_SIZE : $Container/ShotSize/Label,
	Stats.EXTRA_SHOTS : $Container/ExtraShots/Label,
	Stats.SHOT_SPREAD : $Container/ShotSpread/Label,
	Stats.PIERCE : $Container/Pierce/Label,
	Stats.CRIT_CHANCE : $Container/CritChance/Label
}

var target_time_scale = 1
var add_mode = true
var highlights = [null, null]


# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect('stats_changed', self, '_on_stats_changed')
	update_stat_labels()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
#	pos.text = "Pos: " + str(player.position)
	$Container/FPS/Label.text = "FPS: " + str(Engine.get_frames_per_second())
	$Container/TimeScale/Label.text = "Time Scale: " + str(Engine.time_scale)


func update_stat_labels():
	$Container/MaxHP/Label.text = "max_health: " + str(player.max_health)
	$Container/HP/Label.text = "health: " + str(player.health)
	$Container/RegenAmt/Label.text = "regen_amt: " + str(player.regen_amt)
	$Container/RegenTime/Label.text = "regen_time: " + str(player.regen_time)
	$Container/XP/Label.text = "xp: " + str(player.xp)
	$Container/XPGain/Label.text = "xp_gain: " + str(player.xp_gain)
	$Container/Level/Label.text = "lvl: " + str(player.lvl)
	$Container/LevelChoices/Label.text = "lvl_choices: " + str(player.lvl_choices)
	$Container/PickupDistance/Label.text = "pickup_dist: " + str(player.pickup_dist)
	$Container/Speed/Label.text = "speed: " + str(player.speed)
	$Container/Dmg/Label.text = "damage: " + str(player.damage)
	$Container/Ammo/Label.text = "extra_ammo: " + str(player.extra_ammo)
	$Container/FireRate/Label.text = "fire_rate: " + str(player.fire_rate)
	$Container/ReloadSpeed/Label.text = "reload_speed: " + str(player.reload_speed)
	$Container/ShotSpeed/Label.text = "shot_speed: " + str(player.shot_speed)
	$Container/ShotSize/Label.text = "shot_size: " + str(player.shot_size)
	$Container/ExtraShots/Label.text = "extra_shots: " + str(player.extra_shots)
	$Container/ShotSpread/Label.text = "shot_spread: " + str(player.shot_spread)
	$Container/Pierce/Label.text = "pierce: " + str(player.pierce)
	$Container/CritChance/Label.text = "crit_chance: " + str(player.crit_chance)


func _on_stats_changed(stat):
	update_stat_labels()
	highlight_label(labels[stat])


func _on_FPS_text_entered(new_text):
	Engine.set_target_fps(int(new_text))
	$Container/FPS/Label.text = "FPS: " + new_text
	release_all()


func _on_TimeScale_text_entered(new_text):
	Engine.time_scale = float(new_text)
	target_time_scale = float(new_text)
	release_all()


func _on_MaxHP_text_entered(new_text):
	var stat = Stats.MAX_HEALTH
	var val = float(new_text)
	player.set_stats(stat, val, add_mode)
	release_all()


func _on_HP_text_entered(new_text):
	var stat = Stats.HEALTH
	var val = float(new_text)
	player.set_stats(stat, val, add_mode)
	release_all()


func _on_Dmg_text_entered(new_text):
	var stat = Stats.DAMAGE
	var val = float(new_text)
	player.set_stats(stat, val, add_mode)
	release_all()


func _on_Speed_text_entered(new_text):
	var stat = Stats.SPEED
	var val = float(new_text)
	player.set_stats(stat, val, add_mode)
	release_all()


func _on_Ammo_text_entered(new_text):
	var stat = Stats.EXTRA_AMMO
	var val = int(new_text)
	player.set_stats(stat, val, add_mode)
	release_all()


func _on_FireRate_text_entered(new_text):
	var stat = Stats.FIRE_RATE
	var val = float(new_text)
	player.set_stats(stat, val, add_mode)
	release_all()


func _on_ReloadSpeed_text_entered(new_text):
	var stat = Stats.RELOAD_SPEED
	var val = float(new_text)
	player.set_stats(stat, val, add_mode)
	release_all()


func _on_ShotSpeed_text_entered(new_text):
	var stat = Stats.SHOT_SPEED
	var val = float(new_text)
	player.set_stats(stat, val, add_mode)
	release_all()


func _on_ShotCount_text_entered(new_text):
	var stat = Stats.EXTRA_SHOTS
	var val = int(new_text)
	player.set_stats(stat, val, add_mode)
	release_all()


func _on_ShotSpread_text_entered(new_text):
	var stat = Stats.SHOT_SPREAD
	var val = int(new_text)
	player.set_stats(stat, val, add_mode)
	release_all()


func _on_Pierce_text_entered(new_text):
	var stat = Stats.PIERCE
	var val = int(new_text)
	player.set_stats(stat, val, add_mode)
	release_all()


func _on_PickupDistance_text_entered(new_text):
	var stat = Stats.PICKUP_DIST
	var val = float(new_text)
	player.set_stats(stat, val, add_mode)
	release_all()


func _on_XP_text_entered(new_text):
	var stat = Stats.XP
	var val = int(new_text)
	player.set_stats(stat, val, add_mode)
	release_all()


func _on_XPGain_text_entered(new_text):
	var stat = Stats.XP_GAIN
	var val = float(new_text)
	player.set_stats(stat, val, add_mode)
	release_all()


func _on_Level_text_entered(new_text):
	var stat = Stats.LVL
	var val = int(new_text)
	player.set_stats(stat, val, add_mode)
	release_all()


func _on_LevelChoices_text_entered(new_text):
	var stat = Stats.LVL_CHOICES
	var val = int(new_text)
	player.set_stats(stat, val, add_mode)
	release_all()


func _on_RegenAmt_text_entered(new_text):
	var stat = Stats.REGEN_AMT
	var val = int(new_text)
	player.set_stats(stat, val, add_mode)
	release_all()


func _on_RegenTime_text_entered(new_text):
	var stat = Stats.REGEN_TIME
	var val = float(new_text)
	player.set_stats(stat, val, add_mode)
	release_all()


func _on_CritChance_text_entered(new_text):
	var stat = Stats.CRIT_CHANCE
	var val = float(new_text)
	player.set_stats(stat, val, add_mode)
	release_all()


func _on_ShotSize_text_entered(new_text):
	var stat = Stats.SHOT_SIZE
	var val = float(new_text)
	player.set_stats(stat, val, add_mode)
	release_all()


func release_all():
	for x in controls:
		x.text = ''
		if x.has_focus(): x.release_focus()


func highlight_label(node):
	if highlights[0] != node:
		highlights.insert(0, node)
		
		var pop = highlights.pop_back()
		if pop: pop.set("custom_colors/font_color", Color.white)
		
		if highlights[0]:
			highlights[0].set("custom_colors/font_color", Color(1, 1, 0))
		if highlights[1]:
			highlights[1].set("custom_colors/font_color", Color(1, 1, 0.6))


func _on_ModeButton_toggled(button_pressed):
	add_mode = !button_pressed
	if add_mode:
		$Container/ModeButton/Label.text = "ADD"
	else:
		$Container/ModeButton/Label.text = "SET"

extends CanvasLayer


# Declare member variables here. Examples:
onready var player = Game.get_player()
onready var controls = [
		$Container/FPS, $Container/TimeScale, $Container/MaxHP, $Container/HP,
		$Container/XP, $Container/XPGain, $Container/Level, $Container/LevelChoices,
		$Container/PickupDistance, $Container/Speed, $Container/Dmg,  $Container/Ammo,
		$Container/FireRate, $Container/ReloadSpeed, $Container/ShotSpeed,
		$Container/ShotCount, $Container/ShotSpread, $Container/Pierce
		]

var target_time_scale = 1
var add_mode = true


# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect('stats_changed', self, 'update_stat_labels')
	update_stat_labels()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
#	pos.text = "Pos: " + str(player.position)
	$Container/FPS/Label.text = "FPS: " + str(Engine.get_frames_per_second())
	$Container/TimeScale/Label.text = "Time Scale: " + str(Engine.time_scale)


func update_stat_labels():
	$Container/MaxHP/Label.text = "max_health: " + str(player.max_health)
	$Container/HP/Label.text = "health: " + str(player.health)
	$Container/XP/Label.text = "xp: " + str(player.xp)
	$Container/XPGain/Label.text = "xp_gain: " + str(player.xp_gain)
	$Container/Level/Label.text = "lvl: " + str(player.lvl)
	$Container/LevelChoices/Label.text = "lvl_choices: " + str(player.lvl_choices)
	$Container/PickupDistance/Label.text = "pickup_dist: " + str(player.pickup_dist)
	$Container/Speed/Label.text = "speed: " + str(player.speed)
	$Container/Dmg/Label.text = "damage: " + str(player.damage)
	$Container/Ammo/Label.text = "ammo_mod: " + str(player.ammo_mod)
	$Container/FireRate/Label.text = "fire_rate: " + str(player.fire_rate)
	$Container/ReloadSpeed/Label.text = "reload_speed: " + str(player.reload_speed)
	$Container/ShotSpeed/Label.text = "shot_speed: " + str(player.shot_speed)
	$Container/ShotCount/Label.text = "shot_count: " + str(player.shot_count)
	$Container/ShotSpread/Label.text = "shot_spread: " + str(player.shot_spread)
	$Container/Pierce/Label.text = "pierce: " + str(player.pierce)


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
	set_label_color($Container/MaxHP, Color.yellow)
	release_all()


func _on_HP_text_entered(new_text):
	var stat = Stats.HEALTH
	var val = float(new_text)
	if add_mode:
		player.heal(val)
	else:
		player.set_stats(stat, val)
	set_label_color($Container/HP, Color.yellow)
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
	var stat = Stats.AMMO_MOD
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
	var stat = Stats.SHOT_COUNT
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


func release_all():
	for x in controls:
		x.text = ''
		if x.has_focus(): x.release_focus()


func set_label_color(node, color):
	for x in controls:
		if x != node: # don't think this comparison works
			node.get_node("Label").remove_color_override("font_color")
	node.get_node("Label").add_color_override("font_color", color)


func _on_ModeButton_toggled(button_pressed):
	add_mode = !add_mode
	if add_mode:
		$Container/ModeButton/Label.text = "add_stats( )"
	else:
		$Container/ModeButton/Label.text = "set_stats( )"

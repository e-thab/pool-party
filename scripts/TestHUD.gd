extends CanvasLayer


# Declare member variables here. Examples:
onready var player = get_tree().get_nodes_in_group("player")[0]
onready var fps = $Control/FPS
onready var tscale = $Control/TimeScale
onready var max_hp_edit = $Control/MaxHP
onready var hp_edit = $Control/HP
onready var dmg_edit = $Control/Dmg
onready var speed_edit = $Control/Speed
onready var ammo_edit = $Control/Ammo
onready var fire_rate_edit = $Control/FireRate
onready var reload_speed_edit = $Control/ReloadSpeed
onready var shot_speed_edit = $Control/ShotSpeed
onready var shot_count_edit = $Control/ShotCount
onready var shot_spread_edit = $Control/ShotSpread
onready var piercing_edit = $Control/Piercing

#var pos
var controls


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#controls = [fps, tscale, max_hp_edit, hp_edit, dmg_edit, speed_edit, ammo_edit, fire_rate_edit,
	#reload_speed_edit, shot_speed_edit, shot_count_edit, shot_spread_edit, piercing_edit]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
#	pos.text = "Pos: " + str(player.position)
	$Control/FPS/Label.text = "FPS: " + str(Engine.get_frames_per_second())
	
	
#	if not hp_edit.has_focus():
#		hp_edit.text = str(player.health)
#	if not dmg_edit.has_focus():
#		dmg_edit.text = str(player.damage)
#	if not speed_edit.has_focus():
#		speed_edit.text = str(player.speed)
#	if not fire_rate_edit.has_focus():
#		fire_rate_edit.text = str(player.fire_rate)
#	if not shot_speed_edit.has_focus():
#		shot_speed_edit.text = str(player.shot_speed)
#	if not reload_edit.has_focus():
#		reload_edit.text = str(player.reload_speed)


#func _on_HPEdit_value_entered(val):
#	player.health = val
#	player.update_health_bar()
#
#
#func _on_DmgEdit_value_entered(val):
#	player.damage = val
#
#
#func _on_SpeedEdit_value_entered(val):
#	player.speed = val
#
#
#func _on_ShotSpeedEdit_value_entered(val):
#	player.shot_speed = val
#
#
#func _on_ReloadEdit_value_entered(val):
#	player.reload_speed = val
#
#
#func _on_FireRateEdit_value_entered(val):
#	player.fire_rate = val
#
#
#func _on_TimeScaleEdit_text_entered(new_text):
#	$Labels/TimeScale/TimeScaleEdit.release_focus()
#	Engine.time_scale = float(new_text)
#
#
#func _on_FPSEdit_text_entered(new_text):
#	$Labels/FPS/FPSEdit.release_focus()
#	Engine.set_target_fps(int(new_text))


func _on_FPS_text_entered(new_text):
	Engine.set_target_fps(int(new_text))
	$Control/FPS/Label.text = "FPS: " + new_text
	fps.release_focus()


func _on_TimeScale_text_entered(new_text):
	Engine.time_scale = float(new_text)
	tscale.release_focus()


func _on_MaxHP_text_entered(new_text):
	player.max_health = float(new_text)
	max_hp_edit.release_focus()


func _on_HP_text_entered(new_text):
	player.health = float(new_text)
	hp_edit.release_focus()


func _on_Dmg_text_entered(new_text):
	player.damage = float(new_text)
	dmg_edit.release_focus()


func _on_Speed_text_entered(new_text):
	player.speed = float(new_text)
	speed_edit.release_focus()


func _on_Ammo_text_entered(new_text):
	player.ammo_mod = float(new_text)
	ammo_edit.release_focus()


func _on_FireRate_text_entered(new_text):
	player.fire_rate = float(new_text)
	fire_rate_edit.release_focus()


func _on_ReloadSpeed_text_entered(new_text):
	player.reload_speed = float(new_text)
	reload_speed_edit.release_focus()


func _on_ShotSpeed_text_entered(new_text):
	player.shot_speed = float(new_text)
	shot_speed_edit.release_focus()


func _on_ShotCount_text_entered(new_text):
	player.shot_count = float(new_text)
	shot_count_edit.release_focus()


func _on_ShotSpread_text_entered(new_text):
	player.shot_spread = float(new_text)
	shot_spread_edit.release_focus()


func _on_Piercing_text_entered(new_text):
	player.piercing = float(new_text)
	piercing_edit.release_focus()

extends CanvasLayer


# Declare member variables here. Examples:
var player
var fps
var tscale
#var pos
var max_hp_edit
var hp_edit
var dmg_edit
var speed_edit
var ammo_edit
var fire_rate_edit
var reload_speed_edit
var shot_speed_edit
var shot_count_edit
var shot_spread_edit
var piercing_edit

var controls


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_owner().get_node("Player1")
	fps = $Control/FPS/Label
	tscale = $Control/TimeScale
	#pos = $Labels/PlayerPos
	max_hp_edit = $Control/MaxHP
	hp_edit = $Control/HP
	dmg_edit = $Control/FPS
	speed_edit = $Control/Speed
	ammo_edit = $Control/Ammo
	fire_rate_edit = $Control/FireRate
	reload_speed_edit = $Control/ReloadSpeed
	shot_speed_edit = $Control/ShotSpeed
	shot_count_edit = $Control/ShotCount
	shot_spread_edit = $Control/ShotSpread
	piercing_edit = $Control/Piercing
	
	controls = [fps, tscale, max_hp_edit, hp_edit, dmg_edit, speed_edit, ammo_edit, fire_rate_edit,
	reload_speed_edit, shot_speed_edit, shot_count_edit, shot_spread_edit, piercing_edit]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
#	pos.text = "Pos: " + str(player.position)
	fps.text = "FPS: " + str(Engine.get_frames_per_second())
	
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


func _on_TimeScale_text_entered(new_text):
	Engine.time_scale = float(new_text)


func _on_MaxHP_text_entered(new_text):
	pass # Replace with function body.


func _on_HP_text_entered(new_text):
	pass # Replace with function body.


func _on_Dmg_text_entered(new_text):
	pass # Replace with function body.


func _on_Speed_text_entered(new_text):
	pass # Replace with function body.


func _on_Ammo_text_entered(new_text):
	pass # Replace with function body.


func _on_FireRate_text_entered(new_text):
	pass # Replace with function body.


func _on_ReloadSpeed_text_entered(new_text):
	pass # Replace with function body.


func _on_ShotSpeed_text_entered(new_text):
	pass # Replace with function body.


func _on_ShotCount_text_entered(new_text):
	pass # Replace with function body.


func _on_ShotSpread_text_entered(new_text):
	pass # Replace with function body.


func _on_Piercing_text_entered(new_text):
	pass # Replace with function body.

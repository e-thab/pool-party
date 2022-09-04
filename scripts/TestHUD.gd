extends CanvasLayer


# Declare member variables here. Examples:
var player
var fps
var pos
var hp_edit
var dmg_edit
var speed_edit
var fire_rate_edit
var shot_speed_edit
var reload_edit


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_owner().get_node("Player1")
	fps = $Labels/FPS
	pos = $Labels/PlayerPos
	hp_edit = $Labels/PlayerHP/HPEdit
	dmg_edit = $Labels/PlayerDmg/DmgEdit
	speed_edit = $Labels/PlayerSpeed/SpeedEdit
	fire_rate_edit = $Labels/FireRate/FireRateEdit
	shot_speed_edit = $Labels/ShotSpeed/ShotSpeedEdit
	reload_edit = $Labels/Reload/ReloadEdit


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pos.text = "Pos: " + str(player.position)
	fps.text = "FPS: " + str(Engine.get_frames_per_second())
	
	if not hp_edit.has_focus():
		hp_edit.text = str(player.health)
	if not dmg_edit.has_focus():
		dmg_edit.text = str(player.damage)
	if not speed_edit.has_focus():
		speed_edit.text = str(player.speed)
	if not fire_rate_edit.has_focus():
		fire_rate_edit.text = str(player.fire_rate)
	if not shot_speed_edit.has_focus():
		shot_speed_edit.text = str(player.shot_speed)
	if not reload_edit.has_focus():
		reload_edit.text = str(player.reload_speed)


func _on_HPEdit_value_entered(val):
	player.health = val
	player.update_health_bar()


func _on_DmgEdit_value_entered(val):
	player.damage = val


func _on_SpeedEdit_value_entered(val):
	player.speed = val


func _on_ShotSpeedEdit_value_entered(val):
	player.shot_speed = val


func _on_ReloadEdit_value_entered(val):
	player.reload_speed = val


func _on_FireRateEdit_value_entered(val):
	player.fire_rate = val


func _on_TimeScaleEdit_text_entered(new_text):
	$Labels/TimeScale/TimeScaleEdit.release_focus()
	Engine.time_scale = float(new_text)


func _on_FPSEdit_text_entered(new_text):
	$Labels/FPS/FPSEdit.release_focus()
	Engine.set_target_fps(int(new_text))

extends CanvasLayer


# Declare member variables here. Examples:
onready var player = Game.get_player()
onready var controls = [
		$Container/FPS, $Container/TimeScale, $Container/MaxHP, $Container/HP,
		$Container/Dmg, $Container/Speed, $Container/Ammo, $Container/FireRate,
		$Container/ReloadSpeed, $Container/ShotSpeed, $Container/ShotCount,
		$Container/ShotSpread, $Container/Pierce, $Container/PickupDistance,
		$Container/XP
		]

var target_time_scale = 1


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
#	pos.text = "Pos: " + str(player.position)
	$Container/FPS/Label.text = "FPS: " + str(Engine.get_frames_per_second())
	$Container/TimeScale/Label.text = "Time Scale: " + str(Engine.time_scale)


func _on_FPS_text_entered(new_text):
	Engine.set_target_fps(int(new_text))
	$Container/FPS/Label.text = "FPS: " + new_text
	release_all()


func _on_TimeScale_text_entered(new_text):
	Engine.time_scale = float(new_text)
	target_time_scale = float(new_text)
	release_all()


func _on_MaxHP_text_entered(new_text):
	player.set_stats(Stats.MAX_HEALTH, float(new_text))
	release_all()


func _on_HP_text_entered(new_text):
	player.set_stats(Stats.HEALTH, float(new_text))
	release_all()


func _on_Dmg_text_entered(new_text):
	player.set_stats(Stats.DAMAGE, float(new_text))
	release_all()


func _on_Speed_text_entered(new_text):
	player.set_stats(Stats.SPEED, float(new_text))
	release_all()


func _on_Ammo_text_entered(new_text):
	player.set_stats(Stats.AMMO_MOD, float(new_text))
	release_all()


func _on_FireRate_text_entered(new_text):
	player.set_stats(Stats.FIRE_RATE, float(new_text))
	release_all()


func _on_ReloadSpeed_text_entered(new_text):
	player.set_stats(Stats.RELOAD_SPEED, float(new_text))
	release_all()


func _on_ShotSpeed_text_entered(new_text):
	player.set_stats(Stats.SHOT_SPEED, float(new_text))
	release_all()


func _on_ShotCount_text_entered(new_text):
	player.set_stats(Stats.SHOT_COUNT, float(new_text))
	release_all()


func _on_ShotSpread_text_entered(new_text):
	player.set_stats(Stats.SHOT_SPREAD, float(new_text))
	release_all()


func _on_Piercing_text_entered(new_text):
	player.set_stats(Stats.PIERCE, float(new_text))
	release_all()


func _on_PickupDistance_text_entered(new_text):
	player.set_stats(Stats.PICKUP_DIST, float(new_text))
	release_all()


func _on_XP_text_entered(new_text):
	player.set_stats(Stats.XP, float(new_text))
	release_all()


func release_all():
	for x in controls:
		if x.has_focus(): x.release_focus()

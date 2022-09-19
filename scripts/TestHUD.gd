extends CanvasLayer


# Declare member variables here. Examples:
onready var player = get_tree().get_nodes_in_group("player")[0]
#onready var fps = $FPS
#onready var tscale = $TimeScale
#onready var max_hp_edit = $MaxHP
#onready var hp_edit = $HP
#onready var dmg_edit = $Dmg
#onready var speed_edit = $Speed
#onready var ammo_edit = $Ammo
#onready var fire_rate_edit = $FireRate
#onready var reload_speed_edit = $ReloadSpeed
#onready var shot_speed_edit = $ShotSpeed
#onready var shot_count_edit = $ShotCount
#onready var shot_spread_edit = $ShotSpread
#onready var pierce_edit = $Pierce
#onready var pickup_distance_edit = $PickupDistance

#var pos
#var controls


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
#	pos.text = "Pos: " + str(player.position)
	$FPS/Label.text = "FPS: " + str(Engine.get_frames_per_second())


func _on_FPS_text_entered(new_text):
	Engine.set_target_fps(int(new_text))
	$FPS/Label.text = "FPS: " + new_text
	release_all()


func _on_TimeScale_text_entered(new_text):
	Engine.time_scale = float(new_text)
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
	var controls = [
		$FPS, $TimeScale, $MaxHP, $HP, $Dmg, $Speed, $Ammo, $FireRate, $ReloadSpeed,
		$ShotSpeed, $ShotCount, $ShotSpread, $Pierce, $PickupDistance, $XP
		]
	for x in controls:
		if x.has_focus(): x.release_focus()

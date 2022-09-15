extends CanvasLayer


# Declare member variables here. Examples:
onready var player = get_tree().get_nodes_in_group("player")[0]
onready var fps = $FPS
onready var tscale = $TimeScale
onready var max_hp_edit = $MaxHP
onready var hp_edit = $HP
onready var dmg_edit = $Dmg
onready var speed_edit = $Speed
onready var ammo_edit = $Ammo
onready var fire_rate_edit = $FireRate
onready var reload_speed_edit = $ReloadSpeed
onready var shot_speed_edit = $ShotSpeed
onready var shot_count_edit = $ShotCount
onready var shot_spread_edit = $ShotSpread
onready var piercing_edit = $Piercing

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
	$FPS/Label.text = "FPS: " + str(Engine.get_frames_per_second())


func _on_FPS_text_entered(new_text):
	Engine.set_target_fps(int(new_text))
	$FPS/Label.text = "FPS: " + new_text
	fps.release_focus()


func _on_TimeScale_text_entered(new_text):
	Engine.time_scale = float(new_text)
	tscale.release_focus()


func _on_MaxHP_text_entered(new_text):
	player.max_health = float(new_text)
	player.update_health_bar()
	print('setting max health')
	max_hp_edit.release_focus()


func _on_HP_text_entered(new_text):
	player.health = float(new_text)
	player.update_health_bar()
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

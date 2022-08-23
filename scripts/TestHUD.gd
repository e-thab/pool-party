extends CanvasLayer


# Declare member variables here. Examples:
var player
var pos
var hp_edit
var dmg_edit
var speed_edit


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_owner().get_node("Player1")
	pos = $Labels/PlayerPos
	hp_edit = $Labels/PlayerHP/HPEdit
	dmg_edit = $Labels/PlayerDmg/DmgEdit
	speed_edit = $Labels/PlayerSpeed/SpeedEdit


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pos.text = str(player.position)
	
	if not hp_edit.has_focus():
		hp_edit.text = str(player.health)
	if not dmg_edit.has_focus():
		dmg_edit.text = str(player.damage)
	if not speed_edit.has_focus():
		speed_edit.text = str(player.speed)


func _on_HPEdit_value_entered(val):
	player.health = val
	player.update_health_bar()


func _on_DmgEdit_value_entered(val):
	player.damage = val


func _on_SpeedEdit_value_entered(val):
	player.speed = val

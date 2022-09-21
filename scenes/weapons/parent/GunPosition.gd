extends Node2D

onready var player  = get_tree().get_nodes_in_group("player")[0]
var player_pos = Vector2.ZERO
var cursor_pos = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	cursor_pos = get_global_mouse_position()
	player_pos = player.position
	
	position = (cursor_pos - player_pos).normalized() * 50
	rotation = cursor_pos.angle_to_point(player_pos)

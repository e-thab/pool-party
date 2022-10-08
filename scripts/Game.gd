extends Node



onready var player = get_tree().get_nodes_in_group("player")[0]


func get_player():
	return player

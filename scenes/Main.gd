extends Node


# Declare member variables here. Examples:
onready var player = $Player1
onready var tile = $Tile

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tile.offset = player.position

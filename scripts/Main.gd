extends Node


# Declare member variables here. Examples:
onready var player = $Player1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	# background movement
	#tile.position = player.position
	#tile.region_rect = Rect2(player.position.x / 2, player.position.y / 2, 612, 400)
	
	# item positioning
	#item_slot.position = $Player1/GunPosition.position
	#item_slot.rotation = $Player1/GunPosition.rotation

extends Node2D

onready var player  = get_tree().get_nodes_in_group("player")[0]


#func _ready():
#	pass # Replace with function body.


func _physics_process(delta):
	var dist = (position - player.position).length()
	
	if dist <= 10:
		pickup()
		
	elif dist <= player.pickup_distance:
		var dir = position.direction_to(player.position).normalized()
		position += (dir * (delta*7500))/dist


func pickup():
	print('item picked up')
	queue_free()

extends Node2D

onready var player  = get_tree().get_nodes_in_group("player")[0]
var seeking = false

#func _ready():
#	pass # Replace with function body.


func _physics_process(delta):
	var dist = (position - player.position).length()
	
	if dist <= 10:
		pickup()
	elif seeking:
		var dir = position.direction_to(player.position).normalized()
		#position += dir * delta * player.speed * 2.5
		position += dir * delta * 7500
	elif dist <= player.pickup_dist:
		seeking = true
	
#	if dist <= 10:
#		pickup()
#	elif dist <= player.pickup_dist:
#		var dir = position.direction_to(player.position).normalized()
#		position += (dir * (delta*7500))/dist


func pickup():
	print('item picked up')
	queue_free()

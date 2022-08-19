extends RigidBody2D


# Declare member variables here. Examples:
var health = 2
var dmg = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func hurt(dmg):
	health -= dmg
	print("mob hurt. hp = " + str(health))


func _on_Mob1_body_entered(body):
	if body.is_in_group("players"):
		emit_signal("do_damage")
	queue_free()

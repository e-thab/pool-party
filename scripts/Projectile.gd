extends Area2D


# Declare member variables here. Examples:
var speed = 100
var damage = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += (transform.x * delta * speed) / scale


func apply_dmg(dmg):
	print("damage applied")
	damage = dmg

func apply_spd(s):
	speed = s


func _on_Projectile_body_entered(body):
	if body.is_in_group("mobs"):
		print("body is in group mobs, calling hurt()")
		body.hurt(damage)
	else:
		print("body is not in group mobs")
	queue_free()

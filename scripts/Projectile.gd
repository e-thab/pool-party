extends Area2D


# Declare member variables here. Examples:
var speed = 100
var damage = 0


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += (transform.x * delta * speed) / scale


func apply_dmg(dmg):
	damage = dmg

func apply_spd(s):
	speed = s


func _on_Projectile_body_entered(body):
	if body.is_in_group("mobs"):
		body.hurt(damage)
	if not body.is_in_group("players"):
		queue_free()


func _on_Lifetime_timeout():
	queue_free()

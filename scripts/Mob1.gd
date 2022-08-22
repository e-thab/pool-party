extends RigidBody2D


# Declare member variables here. Examples:
var health = 2
var damage = 1
var speed = 50


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += delta * speed


func hurt(dmg):
	health -= dmg
	print("mob hurt. hp = " + str(health))


func die():
	$Particles2D.emitting


func _on_Mob1_body_entered(body):
	if body.is_in_group("players"):
		body.hurt(damage)

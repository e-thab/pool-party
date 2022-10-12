extends RigidBody2D


# Declare member variables here. Examples:
export(Material) var fire_material
export(Material) var hurt_material

var max_health = 2.0
var damage = 0.5
var speed = 25.0
var being_hurt = false

var health


# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += delta * speed * Stats.SPEED_MODIFIER
	
	if being_hurt: # this is meh
		$Particles2D.process_material = hurt_material
	else:
		$Particles2D.process_material = fire_material
	
	if health <= 0:
		die()


func hurt(n):
	health -= n
	#print("mob hurt. hp = " + str(health))
	
	if not being_hurt: # continuation of meh
		being_hurt = true
		yield(get_tree().create_timer(0.2), "timeout")
		being_hurt = false
	#$Particles2D.amount = health * 48


func die():
	$Particles2D.emitting = false


func _on_Mob1_body_entered(body):
	if body.is_in_group("players"):
		body.hurt(damage)

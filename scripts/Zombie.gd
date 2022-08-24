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
	
	if not being_hurt:
		$AnimatedSprite.play("walk")
	
	if health <= 0:
		die()


func hurt(n):
	health -= n
	being_hurt = true
	$AnimatedSprite.play("hurt")
	print("zombie hurt. hp = " + str(health))


func die():
	# do die stuff
	queue_free()


func _on_Zombie_body_entered(body):
	if body.is_in_group("players"):
		body.hurt(damage)


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "hurt":
		being_hurt = false # make this (i frames duration) more controllable
		$AnimatedSprite.stop()

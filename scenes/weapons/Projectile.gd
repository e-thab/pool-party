extends Area2D


# Declare member variables here. Examples:
var speed = 100.0
var size = 100.0
var damage = 0.0
var pierce = 0
var crit = false
var fading = false


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += (transform.x * delta * speed * Stats.SPEED_MODIFIER) / scale


func set_stats(dmg, spd, sze, prc, crt):
	damage = round(dmg)
	speed = spd
	size = sze
	pierce = prc
	crit = crt
	set_size()
	$Particles2D.amount = $Particles2D.amount * (spd / 100) # lower framerates can't keep up


func set_size():
	$Particles2D.process_material.scale = 0.6 * size/100.0
	$CollisionShape2D.shape.radius = 4 * size/100.0


func _on_Projectile_body_entered(body):
	if body.is_in_group("mobs"):
		if not fading:
			body.hurt(damage, crit)
			pierce -= 1
			if pierce <= -1: fade()
	elif not body.is_in_group("player") and not fading:
		fade()


func _on_Lifetime_timeout():
	fade()


func fade():
	fading = true
	$CollisionShape2D.set_deferred("Disabled", true)
	$Particles2D.emitting = false
	yield(get_tree().create_timer(1), "timeout") # can resume after projectile is freed?
	queue_free()

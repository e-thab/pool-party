extends Area2D


# Declare member variables here. Examples:
var speed = 100.0
var damage = 0.0


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += (transform.x * delta * speed) / scale


func set_dmg(n):
	damage = n

func set_spd(n):
	speed = n
	$Particles2D.amount = $Particles2D.amount * (n / 100.0) # lower framerates can't keep up


func _on_Projectile_body_entered(body):
	if body.is_in_group("mobs"):
		body.hurt(damage)
	if not body.is_in_group("player"):
		queue_free()


func _on_Lifetime_timeout():
	$Particles2D.emitting = false
	$CollisionShape2D.set_deferred("Disabled", true)
	yield(get_tree().create_timer(1), "timeout") # can resume after projectile is freed
	if not null: queue_free()

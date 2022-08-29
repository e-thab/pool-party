extends RigidBody2D


# Declare member variables here. Examples:
onready var player  = get_tree().get_nodes_in_group("player")[0]

export(Array, SpriteFrames) var zombie_types

var max_health = 2.0
var damage = 0.5
var speed = 33.3
var being_hurt = false
var health

var velocity
var move_target

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	move_target = player
	
	# randomly choose sprite type
	randomize()
	$AnimatedSprite.frames = zombie_types[randi() % 2]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (position - player.position).length() > 1000:
		queue_free()
	if health <= 0:
		die()
	
	# move toward target
	velocity = position.direction_to(move_target.position).normalized()
	velocity = velocity * speed * Stats.SPEED_MODIFIER
	position += velocity * delta
	
	# flip sprite left/right
	if velocity.x < 0:
		$AnimatedSprite.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite.flip_h = false
	
	# wait until hurt animation is done to resume walk
	if not being_hurt:
		$AnimatedSprite.play("walk")


func hurt(n):
	health -= n
	being_hurt = true
	$AnimatedSprite.play("hurt")
	print("zombie hurt. hp = " + str(health))


func die():
	# do death stuff
	queue_free()


func set_move_target(target):
	move_target = target


func _on_Zombie_body_entered(body):
	if body.is_in_group("player"):
		body.hurt(damage)


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "hurt":
		being_hurt = false
		$AnimatedSprite.stop()

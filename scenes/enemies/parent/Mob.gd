extends RigidBody2D


signal enemy_death

export(Array, SpriteFrames) var mob_types
export(Array, PackedScene) var drops
onready var player  = get_tree().get_nodes_in_group("player")[0]
onready var root = get_tree().get_root()

var max_health = 2.0
var damage = 0.5
var speed = 33.3
#var being_hurt = false
var health

var dir = Vector2.ZERO
var move_target
var player_colliding = false

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	move_target = player
	
	$AnimatedSprite.frames = mob_types[randi() % len(mob_types)]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (position - player.position).length() > 4000:
		queue_free()
	if health <= 0:
		die()


func _physics_process(delta):
	# move toward target
	dir = position.direction_to(move_target.position).normalized()
	applied_force = dir * speed * Stats.SPEED_MODIFIER * delta * 100
	
	# naive pathfinding, doesn't really work:
#	var rot
#	for c in get_colliding_bodies():
#		if c.is_in_group("mobs") and (
#			(move_target.position - position).length() > (move_target.position - c.position).length()
#			):
#			#var r = deg2rad(randi() % 180 - 90)
#			#apply_central_impulse((position - c.position).rotated(r) / 2)
#
#			var relative = position.angle_to(c.position)
#			rot = dir.rotated( (PI/2) * (int(relative > dir.angle()) * -1) )
#
#			if relative < dir.angle():
#				add_central_force(dir.rotated(PI/2) * 100)
#			else:
#				add_central_force(dir.rotated(-PI/2) * 100)
#	
#	if rot:
#		applied_force = rot * speed * Stats.SPEED_MODIFIER * delta * 100
#		#add_central_force(-dir * 600)
#	else:
#		applied_force = dir * speed * Stats.SPEED_MODIFIER * delta * 100
	$DebugMovement.set_point_position(1, applied_force.normalized() * 50)
	
	# flip sprite left/right
	if dir.x < 0:
		$AnimatedSprite.flip_h = true
	elif dir.x > 0:
		$AnimatedSprite.flip_h = false
	
	if player_colliding:
		player.hurt(damage)


func hurt(n):
	health -= n
	$AnimatedSprite.play("hurt")
	$AnimatedSprite.frame = 0
	#print("zombie hurt. hp = " + str(health))


func die():
	# do death stuff
	emit_signal("enemy_death")
	if randi()%2:
		var drop = drops[0].instance()
		root.add_child(drop)
		drop.position = global_position
	queue_free()


func set_move_target(target):
	move_target = target


func _on_Mob_body_entered(body):
	if body.is_in_group("player"):
		player_colliding = true
		#body.hurt(damage)

func _on_Mob_body_exited(body):
	if body.is_in_group("player"):
		player_colliding = false


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "hurt":
		$AnimatedSprite.play("walk")




extends RigidBody2D


#signal stats_changed(stat, val)

export(PackedScene) var weapon_type

var max_health = 10.0
var speed = 100.0 # percentage

var max_ammo = 0 # int, adds to weapon max ammo
# variables below are percentages that modify base weapon stats
var damage = 100.0
var fire_rate = 100.0
var shot_speed = 100.0
var reload_speed = 100.0

onready var screen_size  = get_viewport_rect().size
onready var tile = $TileSpriteBG

var moving_left = false
var being_hurt = false
var health = 0.0
var gun


func _ready():
	gun = weapon_type.instance()
	$GunPosition.add_child(gun)
	health = max_health
	update_health_bar()


func _process(delta):
	# get movement input
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	# play animation on move
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed * Stats.SPEED_MODIFIER
		if not being_hurt: $AnimatedSprite.play("run")
	else:
		if not being_hurt: $AnimatedSprite.play("idle")
	
	# face moving direction
	if velocity.x < 0:
		moving_left = true
	elif velocity.x > 0:
		moving_left = false
	$AnimatedSprite.flip_h = moving_left
	
	# apply velocity to position
	position += velocity * delta
	
	# offset background tile to make it look constant
	tile.region_rect = Rect2(position.x / 2, position.y / 2, 612, 400)
	
	# keep tile on screen even in ludicrous speed - looks bad though
	#$PlayerCamera.smoothing_speed = speed * 0.05


func hurt(n):
	# check for on-hit invincibility (duration of hurt animation)
	if not being_hurt:
		health -= n
		being_hurt = true
		$AnimatedSprite.play("hurt")
		update_health_bar()


func heal(n):
	health += n
	update_health_bar()


func update_health_bar():
	# adjust size of red rect; 36 = full, 0 = empty
	#$AnimatedSprite/HealthBar/Fill.rect_size.x = (36.0 / max_health) * health
	$AnimatedSprite/HealthBar.max_value = max_health
	$AnimatedSprite/HealthBar.value = health
	
#	emit_signal("stats_changed", Stats.HEALTH, health)
	print("player hurt. hp = " + str(health))


func _on_PlayerSprite_animation_finished():
	if $AnimatedSprite.animation == "hurt":
		being_hurt = false # make this (i frames duration) more controllable
		$AnimatedSprite.stop()

extends RigidBody2D


export(PackedScene) var weapon_type
export var speed = 200
export var max_health = 10
export var damage = 1 # modifies base damage of weapon

onready var screen_size  = get_viewport_rect().size
onready var tile = $TileSpriteBG

var moving_left = false
var being_hurt = false
var health
var gun


func _ready():
	gun = weapon_type.instance()
	$GunPosition.add_child(gun)
	health = max_health


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
		velocity = velocity.normalized() * speed
		if not being_hurt: $PlayerSprite.play("run")
	else:
		if not being_hurt: $PlayerSprite.play("idle")
	
	# face moving direction
	if velocity.x < 0:
		moving_left = true
	elif velocity.x > 0:
		moving_left = false
	$PlayerSprite.flip_h = moving_left
	
	# apply velocity to position
	position += velocity * delta
	
	# offset background tile to make it look constant
	tile.region_rect = Rect2(position.x / 2, position.y / 2, 612, 400)


func hurt(dmg):
	# check for on-hit invincibility (duration of hurt animation)
	if not being_hurt:
		health -= dmg
		being_hurt = true
		$PlayerSprite.play("hurt")
		update_health_bar()


func heal(hp):
	health += hp
	update_health_bar()


func update_health_bar():
	# adjust size of red rect; 36 = full, 0 = empty
	$PlayerSprite/HealthBar/Fill.rect_size.x = (36.0 / max_health) * health
	print("player hurt. hp = " + str(health))


func _on_PlayerSprite_animation_finished():
	if $PlayerSprite.animation == "hurt":
		being_hurt = false
		$PlayerSprite.stop()

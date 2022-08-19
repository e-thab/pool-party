extends RigidBody2D


export(PackedScene) var weapon_type
export var speed = 200
export var health = 100
export var damage = 1 # modifies base damage of weapon

onready var screen_size  = get_viewport_rect().size
onready var tile = $TileSpriteBG

var moving_left = false
var gun


func _ready():
	gun = weapon_type.instance()
	$GunPosition.add_child(gun)


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
		$PlayerSprite.play("run")
	else:
		$PlayerSprite.play("idle")
	
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
	health -= dmg
	# update health bar here
	print("player hurt. hp = " + str(health))

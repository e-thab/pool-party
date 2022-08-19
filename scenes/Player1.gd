extends Area2D

export var speed = 200
var screen_size


func _ready():
	screen_size = get_viewport_rect().size


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
	
	# flip animation by direction -- this is too quick. should keep flip_h somehow
	$PlayerSprite.flip_h = velocity.x < 0
	
	# apply velocity to position
	position += velocity * delta
	
	# clamp character into screen bounds
	#position.x = clamp(position.x, 0, screen_size.x)
	#position.y = clamp(position.y, 0, screen_size.y)

extends Sprite


# Declare member variables here. Examples:
export(PackedScene) var projectile
onready var root = get_tree().get_root()
var can_fire = true
var base_dmg = 1
var base_spd = 250


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("primary_fire") and can_fire:
		shoot()
	
	flip_v = global_rotation < (-PI/2) or global_rotation > (PI/2)


func shoot():
	can_fire = false
	$ShotTimer.start()
	
	var proj_inst = projectile.instance()
	root.add_child(proj_inst)
	proj_inst.position = $ShotOrigin.global_position
	proj_inst.rotation = $ShotOrigin.global_rotation
	proj_inst.apply_dmg(base_dmg)
	proj_inst.apply_spd(base_spd)


func _on_ShotTimer_timeout():
	can_fire = true

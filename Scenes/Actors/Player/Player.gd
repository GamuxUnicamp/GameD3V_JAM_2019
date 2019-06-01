extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var WALKSPEED = 200
export(int) var JUMPSPEED = 200
export(int) var GRAVITY = 250

var snap_vector = Vector2(0,1)
var floor_normal = Vector2(0,-1)
var linear_velocity = Vector2(0,0)

var can_double_jump = false
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Player")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	linear_velocity.x = 0
	linear_velocity.y += GRAVITY*delta
	if Input.is_action_pressed("ui_left"):
		linear_velocity.x -= WALKSPEED
	if Input.is_action_pressed("ui_right"):
		linear_velocity.x += WALKSPEED
	if linear_velocity.x > 0:
		$Sprite.flip_v = false
		$Weapon.scale.x = 1
	elif linear_velocity.x < 0:
		$Sprite.flip_v = true
		$Weapon.scale.x = -1
	if Input.is_action_just_pressed("ui_j"):
		$Weapon.attack()
	if is_on_floor():
		can_double_jump = true
		linear_velocity.y = 0
		if Input.is_action_just_pressed("ui_up"):
			linear_velocity.y = -JUMPSPEED
	else:
		if Input.is_action_just_pressed("ui_up") and can_double_jump:
			linear_velocity.y = -JUMPSPEED
			can_double_jump = false
	var guarda = move_and_slide_with_snap(linear_velocity, snap_vector, floor_normal)
	#print(guarda)
#	pass

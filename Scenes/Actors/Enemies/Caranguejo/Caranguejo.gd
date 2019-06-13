extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var going = "right"
var normal = Vector2(0,-1)
var right = Vector2()
var left = Vector2()
var speed = 50
var gravity = 600
var velocity = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	if randf()>0.5:
		going = "left"
	normal = (normal.rotated(rotation)).normalized()
	print(rotation)
	print((normal.angle_to(Vector2(0,-1))))
	right = normal.rotated(PI/2)
	left = normal.rotated(-PI/2)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$RayCastLeftGround.force_raycast_update()
	$RayCastRightGround.force_raycast_update()
	$RayCastLeftWall.force_raycast_update()
	$RayCastRightWall.force_raycast_update()
	#print($RayCastLeftWall.is_colliding()," ",$RayCastLeftGround.is_colliding()," ",$RayCastRightGround.is_colliding()," ",$RayCastRightWall.is_colliding())
	if going == "left":
		if $RayCastLeftWall.is_colliding() or not $RayCastLeftGround.is_colliding():
			going = "right"
	elif going == "right":
		if $RayCastRightWall.is_colliding() or not $RayCastRightGround.is_colliding():
			going = "left"
		pass
	velocity -= normal*delta*gravity
	if is_on_floor():
		velocity = Vector2(0,0)
		if going == "left":
			velocity = left*speed
		elif going == "right":
			velocity = right*speed
		pass
	move_and_slide_with_snap(velocity,-0.1*normal,normal)
	pass

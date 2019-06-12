extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var going = "right"
var normal = Vector2(0,-1)
var right = Vector2()
var left = Vector2()
var speed = 200
var velocity = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	if randf()>0.5:
		going = "left"
	normal = normal.normalized()
	right = normal.rotated(PI/2)
	left = normal.rotated(-PI/2)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$RayCastLeftGround.force_raycast_update()
	$RayCastRightGround.force_raycast_update()
	$RayCastLeftWall.force_raycast_update()
	$RayCastRightWall.force_raycast_update()
	if going == "left":
		if $RayCastLeftWall.is_colliding() or not $RayCastLeftGround.is_colliding():
			going = "right"
	elif going == "right":
		if $RayCastRightWall.is_colliding() or not $RayCastRightGround.is_colliding():
			going = "left"
		pass
	if going == "left":
		velocity = left*speed
	elif going == "right":
		velocity = right*speed
	if is_on_floor():
		pass
	pass

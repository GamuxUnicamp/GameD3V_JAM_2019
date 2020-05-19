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
var HP = 30
export(int)var attack_damage = 1
export(int)var knockback_value = 300
# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("body_entered",self,"jogador_entrou")
	add_to_group("Enemy")
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
func morrer():
	$Area2D.queue_free()
	$CollisionShape2D.queue_free()
	set_process(false)
	$Death.play()
	$AnimationPlayer.play("Morrer")
	yield($Death,"finished")
	queue_free()
	pass
func damage(val):
	HP-=val
	if HP <= 0:
		morrer()
	else:
		$Sprite.modulate.a = 0.8
		yield(get_tree().create_timer(0.1),"timeout")
		$Sprite.modulate.a = 1

func jogador_entrou(body):
	if body.is_in_group("Player"):
		if body.has_method("damage_with_knockback"):
			var knockback = knockback_value*(Vector2(3,-1).normalized())
			if body.position.x < position.x:
				knockback.x*=-1
			body.damage_with_knockback(attack_damage,true,knockback,0.5)
		elif body.has_method("damage"):
			body.damage(attack_damage)
extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int)var damage = 10
export(int)var knockback_value = 300
export(float)var cooldown = 0.5
export(int)var HP = 30
var velocity = Vector2(0,0)
var speed = 100
var alvo = null
var locked = false
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Enemy")
	$Boca.connect("body_entered",self,"body_entered")
	pass # Replace with function body.
func body_entered(body):
	if body.is_in_group("Player"):
		if body.has_method("damage_with_knockback"):
			var knockback = knockback_value*(Vector2(3,-1).normalized())
			if body.position.x < position.x:
				knockback.x*=-1
			body.damage_with_knockback(damage,true,knockback,0.5)
		elif body.has_method("damage"):
			body.damage(damage)
		locked = true
		yield(get_tree().create_timer(cooldown),"timeout")
		locked = false
		pass
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if HP <= 0:
		queue_free()
	if not locked:
		if alvo != null:
			velocity = (alvo.position-position).normalized()*speed
			rotation = velocity.angle()
			if velocity.x < 0:
				$Boca.scale.y = -1
				$peixe.flip_v = true
			if velocity.x > 0:
				$Boca.scale.y = 1
				$peixe.flip_v = false
			move_and_slide(velocity)
	else:
		if alvo != null:
			move_and_slide(velocity*-2)
func damage(val):
	HP -= val
	print("HP restante: "+str(HP))
func damage_with_knockback(val, knockback = false, direcao = Vector2(0,0), tempo = 0):
	HP -= val
	if knockback:
		velocity = -direcao
		locked = true
		yield(get_tree().create_timer(cooldown),"timeout")
		locked = false
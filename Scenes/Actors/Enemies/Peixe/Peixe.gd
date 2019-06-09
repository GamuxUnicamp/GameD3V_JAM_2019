extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var saindo_da_parede = false
var distance = 300
var direction = null
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
	randomize()
	add_to_group("Enemy")
	$Deteccao.connect("body_entered",self,"player_entrou")
	$Deteccao.connect("body_exited",self,"player_saiu")
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
	if not alvo == null:
		if not locked:
			velocity = (alvo.position-position).normalized()*speed
			movepeixe()
		else:
			move_and_slide(velocity*-2,Vector2(0,-1))
	else:
		if direction == null:
			direction = Vector2(1,0)
			direction = direction.rotated(2*PI*randf())
			direction*=distance*(0.5+randf()/2)
			direction+=position
		elif (is_on_floor() or is_on_ceiling() or is_on_wall()) and not saindo_da_parede:
			direction = null
			print("To na parede")
			saindo_da_parede = true
			yield(get_tree().create_timer(0.5),"timeout")
			saindo_da_parede = false
		elif position.distance_to(direction) < 5:
			direction = null
			print("Cheguei")
		else:
			velocity = (direction-position).normalized()*speed
			movepeixe()
			
func movepeixe():
	rotation = velocity.angle()
	if velocity.x < 0:
		$Boca.scale.y = -1
		$peixe.flip_v = true
	if velocity.x > 0:
		$Boca.scale.y = 1
		$peixe.flip_v = false
	move_and_slide(velocity,Vector2(0,-1))
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
func player_entrou(body):
	if body.is_in_group("Player"):
		alvo = body
	pass
func player_saiu(body):
	if body.is_in_group("Player"):
		alvo = null
	pass
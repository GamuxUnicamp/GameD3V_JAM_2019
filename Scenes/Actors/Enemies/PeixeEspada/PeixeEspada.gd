extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var saindo_da_parede = false
var distance = 300
var direction = null
export(int)var attack_damage = 1
export(int)var knockback_value = 300
export(float)var cooldown = 0.5
export(int)var HP = 30
var velocity = Vector2(0,0)
var speed = 100
var charge_speed = 500
var charge_duration = 2
var charge_cooldown = 5
var can_charge = true
var alvo = null
var locked = false
# Called when the node enters the scene tree for the first time.
func can_see_player():
	if alvo == null:
		return false
	$RayCast2D.cast_to = (alvo.position-position).rotated(-rotation)
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		if ($RayCast2D.get_collider()).is_in_group("Player"):
			return true
	return false

func _ready():
	randomize()
	$ChageCooldown.connect("timeout",self,"charge_cd")
	$ChageCooldown.wait_time = charge_cooldown+charge_duration
	$LockTimer.connect("timeout",self,"unlock")
	add_to_group("Enemy")
	if $Deteccao.connect("body_entered",self,"player_entrou")!= 0:
		print("connection error")
	if $Deteccao.connect("body_exited",self,"player_saiu") != 0:
		print("connection error")
	if $Boca.connect("body_entered",self,"body_entered") != 0:
		print("connection error")
	pass # Replace with function body.
func body_entered(body):
	if body.is_in_group("Player"):
		if body.has_method("damage_with_knockback"):
			var knockback = knockback_value*(Vector2(3,-1).normalized())
			if body.position.x < position.x:
				knockback.x*=-1
			body.damage_with_knockback(attack_damage,true,knockback,0.5)
		elif body.has_method("damage"):
			body.damage(attack_damage)
		locked = true
		$LockTimer.wait_time = cooldown
		$LockTimer.start()
	pass
func unlock():
	locked = false
func charge_cd():
	can_charge = true
func saiu_da_parede():
	saindo_da_parede = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if HP <= 0:
		queue_free()
	if not alvo == null and can_see_player():
		if not locked:
			if can_charge:
				velocity = (position-alvo.position).normalized()*charge_speed
				rotation = velocity.angle()+PI
				if velocity.x > 0:
					$Boca.scale.y = -1
					$peixe.flip_v = true
				if velocity.x < 0:
					$Boca.scale.y = 1
					$peixe.flip_v = false
				locked = true
				can_charge = false
				$LockTimer.wait_time = charge_duration
				$LockTimer.start()
				$ChageCooldown.start()
			else:
				velocity = (alvo.position-position).normalized()*speed
				movepeixe()
				pass
		else:
			
			move_and_slide(velocity*-1,Vector2(0,-1))
	else:
		if direction == null:
			direction = Vector2(1,0)
			direction = direction.rotated(2*PI*randf())
			direction*=distance*(0.5+randf()/2)
			direction+=position
		elif (is_on_floor() or is_on_ceiling() or is_on_wall()) and not saindo_da_parede:
			direction = null
			saindo_da_parede = true
			get_tree().create_timer(0.5).connect("timeout",self,"saiu_da_parede")
		elif position.distance_to(direction) < 5:
			direction = null
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
func damage_with_knockback(val, knockback = false, direcao = Vector2(0,0), tempo = 0):
	HP -= val
	if knockback:
		velocity = -direcao
		locked = true
		$LockTimer.wait_time = tempo
		$LockTimer.start()
func player_entrou(body):
	if body.is_in_group("Player"):
		alvo = body
	pass
func player_saiu(body):
	if body.is_in_group("Player"):
		alvo = null
	pass
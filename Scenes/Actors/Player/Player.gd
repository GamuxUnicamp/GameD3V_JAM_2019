extends KinematicBody2D

signal morri()

export(int) var WALKSPEED = 200
export(int) var JUMPSPEED = 250
export(int) var GRAVITY = 250
export(int) var TERMINALVELOCITY = 600

var jumping = false
var snap_vector = Vector2(0,0.5)
var floor_normal = Vector2(0,-1)
var linear_velocity = Vector2(0,0)


var sob_controle = true

var facing_right = true

var can_double_jump = false

func _ready():
	add_to_group("Player")
	$StunTimer.connect("timeout",self,"acabou_stun")
	pass

func acabou_stun():
	sob_controle = true
func damage(val):
	global.health -= val
	if global.health > 0:
		$Damage.play()
func damage_with_knockback(val, knockback = false, direcao = Vector2(0,0), tempo = 0):
	global.health -= val
	if global.health > 0:
		$Damage.play()
	if knockback and sob_controle:
		linear_velocity = direcao
		sob_controle = false
		$StunTimer.wait_time = tempo
		$StunTimer.start()

func _process(delta):
	if global.health <= 0:
		global.reset_health()
		$Death.play()
		emit_signal("morri")
	linear_velocity.y += GRAVITY*delta
	if linear_velocity.y > TERMINALVELOCITY:
		linear_velocity.y = TERMINALVELOCITY
	if sob_controle:
		linear_velocity.x = 0
		if Input.is_action_pressed("ui_left"):
			linear_velocity.x -= WALKSPEED
		if Input.is_action_pressed("ui_right"):
			linear_velocity.x += WALKSPEED
		if linear_velocity.x > 0:
			facing_right = true
			$Sprite.flip_h = false
			$Weapon.scale.x = 1
			$Gun.scale.x = 1
		elif linear_velocity.x < 0:
			facing_right = false
			$Sprite.flip_h = true
			$Weapon.scale.x = -1
			$Gun.scale.x = -1
		if Input.is_action_pressed("ui_j"):
			if $Weapon.can_attack:
				$Attack.play()
			$Weapon.attack()
		if Input.is_action_pressed("ui_k") and global.can_shoot:
			$Gun.attack()
		if is_on_ceiling() and linear_velocity.y < 0:
			linear_velocity.y = 0
		if is_on_floor() and not jumping:
			can_double_jump = true
			if linear_velocity.y > 0:
				linear_velocity.y = 0
			if Input.is_action_just_pressed("ui_up"):
				$Jump.play()
				linear_velocity.y = -JUMPSPEED
				jumping = true
				yield(get_tree().create_timer(0.5),"timeout")
				jumping = false
		else:
			if Input.is_action_just_pressed("ui_up") and can_double_jump:
				$Jump.play()
				linear_velocity.y = -JUMPSPEED
				can_double_jump = false
	if not jumping:
		move_and_slide_with_snap(linear_velocity, snap_vector, floor_normal)
	else:
		move_and_slide(linear_velocity, floor_normal)
		
	if $Weapon.atacando:
		$AnimationPlayer.play("Attack")
	elif not is_on_floor():
		$AnimationPlayer.play("Jump")
	elif linear_velocity.x == 0:
		$AnimationPlayer.play("Idle")
	elif $AnimationPlayer.current_animation != "Walking":
		$AnimationPlayer.play("Walking")
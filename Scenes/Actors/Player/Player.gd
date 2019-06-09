extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal paradas_pra_ui(coisas)

export(int) var WALKSPEED = 200
export(int) var JUMPSPEED = 200
export(int) var GRAVITY = 250
export(int) var MAXHITPOINTS = 200 

var snap_vector = Vector2(0,0.1)
var floor_normal = Vector2(0,-1)
var linear_velocity = Vector2(0,0)

var HP = 1

var sob_controle = true

var facing_right = true

var can_double_jump = false
# Called when the node enters the scene tree for the first time.
func _ready():
	HP = MAXHITPOINTS
	add_to_group("Player")
	$StunTimer.connect("timeout",self,"acabou_stun")
	pass # Replace with function body.

func acabou_stun():
	sob_controle = true
func damage(val):
	print("Tomei "+str(val)+" de dano")
	HP -= val
func damage_with_knockback(val, knockback = false, direcao = Vector2(0,0), tempo = 0):
	print("Tomei "+str(val)+" de dano")
	HP -= val
	if knockback and sob_controle:
		linear_velocity = direcao
		sob_controle = false
		$StunTimer.wait_time = tempo
		$StunTimer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if HP <= 0:
		get_tree().change_scene("res://Scenes/Temp/LevelTest2.tscn")
	emit_signal("paradas_pra_ui",{"max_life":MAXHITPOINTS,"life":HP})
	linear_velocity.y += GRAVITY*delta
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
			$Weapon.attack()
		if Input.is_action_pressed("ui_k"):
			$Gun.attack()
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

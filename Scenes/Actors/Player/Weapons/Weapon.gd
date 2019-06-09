extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var can_attack = true
var atacando = false

export(String)var enemy = "Enemy"
export(float)var attack_cooldown = 0.3
export(float)var attack_duration = 0.2
export(int)var weapon_damage = 15
# Called when the node enters the scene tree for the first time.
func _ready():
	$Cooldown.wait_time = attack_cooldown
	$Duration.wait_time = attack_duration
	hide()
	if $Cooldown.connect("timeout",self,"reloaded") != 0:
		print("Failed to connect Signal")
	if $Duration.connect("timeout",self,"attack_ended") != 0:
		print("Failed to connect Signal")
	if connect("body_entered",self,"bateu") != 0:
		print("Failed to connect Signal")
	if connect("area_entered",self,"bateu") != 0:
		print("Failed to connect Signal")
	pass # Replace with function body.
	
func bateu(body):
	if atacando:
		checar_se_bateu([body])

func reloaded():
	can_attack = true

func checar_se_bateu(lista):
	for body in lista:
		if body.is_in_group("Quebravel"):
			body.quebrou(get_parent())
			print(get_parent().HP)
		if body.is_in_group(enemy):
			if body.has_method("damage"):
				body.damage(weapon_damage)
			print("Bateu")

func attack_ended():
	hide()
	atacando = false
	$Cooldown.start()

func attack():
	if can_attack:
		
		checar_se_bateu(get_overlapping_areas())
		checar_se_bateu(get_overlapping_bodies())
		
		show()
		atacando = true
		$Duration.start()
		can_attack = false
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

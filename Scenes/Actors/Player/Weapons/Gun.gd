extends Position2D

var can_attack = true
var bolha_scene = load("res://Scenes/Actors/Player/Weapons/BolhaAtaque.tscn")

export(String)var enemy = "Enemy"
export(String)var ally = "Player"
export(float)var attack_cooldown = 0.5
export(int)var attack_damage = 10
export(int)var attack_speed = 300

func _ready():
	$Cooldown.wait_time = attack_cooldown
	if $Cooldown.connect("timeout",self,"reloaded") != 0:
		print("Failed to connect Signal")
	pass 

func reloaded():
	can_attack = true

func attack():
	if can_attack:
		var bolha = bolha_scene.instance()
		bolha.velocity*=attack_speed
		if scale.x < 0:
			bolha.velocity.x*=-1
		bolha.enemy = enemy
		bolha.ally = ally
		get_parent().get_parent().add_child(bolha)
		bolha.position = get_parent().position
		bolha.damage = attack_damage
		$Cooldown.start()
		can_attack = false
	pass
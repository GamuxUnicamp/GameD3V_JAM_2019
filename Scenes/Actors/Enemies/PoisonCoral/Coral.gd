extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int)var attack_damage = 1
export(int)var knockback_value = 300
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Enemy")
	if connect("body_entered",self,"jogador_entrou") != 0:
		print("connection error")
	if $RegrowTimer.connect("timeout",self,"voltei") != 0:
		print("connection error")
	pass # Replace with function body.

func voltei():
	$Sprite.show()
	remove_from_group("Ignore")
	for body in get_overlapping_bodies():
		jogador_entrou(body)

func damage(val):
	$Sprite.hide()
	$RegrowTimer.start()
	add_to_group("Ignore")

func jogador_entrou(body):
	if body.is_in_group("Player") and not is_in_group("Ignore"):
		if body.has_method("damage_with_knockback"):
			var knockback = knockback_value*(Vector2(3,-1).normalized())
			if body.facing_right:
				knockback.x*=-1
			body.damage_with_knockback(attack_damage,true,knockback,0.5)
		elif body.has_method("damage"):
			body.damage(attack_damage)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

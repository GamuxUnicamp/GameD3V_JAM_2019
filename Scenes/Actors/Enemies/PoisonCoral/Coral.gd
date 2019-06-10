extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int)var attack_damage = 10
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
	monitoring = true
	monitorable = true
	$CollisionShape2D.disabled = false
	remove_from_group("Ignore")

func damage(val):
	print("Coral: Tomei "+str(val)+" de dano")
	$Sprite.hide()
	$RegrowTimer.start()
	$CollisionShape2D.disabled = true
	monitoring = false
	monitorable = false
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

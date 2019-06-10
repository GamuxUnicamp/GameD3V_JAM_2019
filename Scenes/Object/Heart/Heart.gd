extends Area2D

var heal = 0;

func _ready():
	var random = RandomNumberGenerator.new()
	random.randomize()
	heal = random.randi_range(1,3)
	connect("body_entered",self,"pegou")


func pegou(body):
	#mostra animaçao
	if body.is_in_group("Player"):
		global.health += heal
		if global.health  > global.max_health:
			global.health  = global.max_health
		queue_free()

	pass
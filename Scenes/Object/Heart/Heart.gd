extends Area2D

export var heal = 1;

func _ready():
	connect("body_entered",self,"pegou")
	add_to_group("Ignore")


func pegou(body):
	#mostra animaçao
	if body.is_in_group("Player"):
		global.health += heal
		if global.health  > global.max_health:
			global.health  = global.max_health
		queue_free()
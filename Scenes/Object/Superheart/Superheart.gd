extends Area2D


func _ready():
	connect("body_entered",self,"pegou")
	pass 


func pegou(body):
	if body.is_in_group("Player"):
		global.max_health += 1
		global.health = global.max_health
		queue_free() 
		pass
	pass

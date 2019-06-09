extends Area2D

func _ready():
	connect("body_entered",self,"entrou")
	pass 

func entrou(body):
	if body.is_in_group("Player"):
		print("pegou artefato")
		queue_free()
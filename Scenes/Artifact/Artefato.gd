extends Area2D

func _ready():
	add_to_group("Ignore")
	connect("body_entered",self,"entrou")
	pass 

func entrou(body):
	if body.is_in_group("Player"):
		print("pegou artefato")
		global.add_artifact()
		queue_free()
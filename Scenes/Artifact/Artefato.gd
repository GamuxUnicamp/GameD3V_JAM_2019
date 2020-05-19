extends Area2D

func _ready():
	add_to_group("Ignore")
	connect("body_entered",self,"entrou")
	pass 

func entrou(body):
	if body.is_in_group("Player"):
		disconnect("body_entered",self,"entrou")
		$Sprite2.hide()
		$AudioStreamPlayer.play()
		print("pegou artefato")
		global.add_artifact()
		yield($AudioStreamPlayer,"finished")
		queue_free()
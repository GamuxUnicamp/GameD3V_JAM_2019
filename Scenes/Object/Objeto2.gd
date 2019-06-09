extends StaticBody2D

func _ready():
	add_to_group("Quebravel")


func quebrou():
	#mostra animaçao
	get_parent().self_modulate.a = 0.1
	get_parent().add_to_group("Ignore")
	queue_free()

	pass
extends StaticBody2D




var coracao_cena = load("res://Scenes/Object/Heart/Heart.tscn")


func _ready():
	add_to_group("Quebravel")


func quebrou():
	#mostra animaçao
	get_parent().modulate.a = 0.5
	if get_parent().tem_coracao:
		var coracao = coracao_cena.instance()
		coracao.position = get_parent().position
		get_parent().get_parent().add_child(coracao)
	queue_free()

	pass
extends Control

func _ready():
	pass 

func add_digit():
	
	var digitos = $Control/Dialogo
	
	if digitos.get_total_character_count() >= digitos.visible_characters:
		print("+1")
		pass
	else:
		$Digito.start()
		print("Done")
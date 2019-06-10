extends Control

signal Line_End
export var PATH = ""
onready var digitos = $Control/Dialogo


func _ready():
	
	var lines = ["Hello!", "My name is the World!"]
	
	digitos.text = ""
	$Intervalo.start(0)
	yield($Intervalo, "timeout")
	
	for line in lines:
		new_line(line)
		$Digito.start(0)
		yield(self, "Line_End")
		$Intervalo.start(0)
		yield($Intervalo, "timeout")
	
	digitos.text = ""
	$Intervalo.start(1.3)
	yield($Intervalo, "timeout")
	
	get_tree().change_scene(PATH)

func add_digit():
	
	var digitos = $Control/Dialogo
	
	if digitos.get_total_character_count() > digitos.visible_characters:
		digitos.visible_characters += 1
	
	else:
		$Digito.stop()
		emit_signal("Line_End")

func new_line(line):
	digitos.text = line
	digitos.visible_characters = 0
	print(digitos.text)
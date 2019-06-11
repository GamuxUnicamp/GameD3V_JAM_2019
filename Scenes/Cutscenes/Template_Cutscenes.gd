extends Control

signal Line_End
export var PATH = ""
export(Array) var blabla
onready var digitos = $Control/Dialogo


func _ready():
	
	var lines = blabla
	
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
	$Intervalo.start(0)
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
	digitos.text = line.right(2)
	digitos.visible_characters = 0
	
	if line[0] == "L":
		digitos.add_color_override("font_color_shadow", Color( 0.53, 0.81, 0.98, 1 ))
		
	elif line[0] == "S":
		digitos.add_color_override("font_color_shadow", Color( 0.69, 0.19, 0.38, 1 ))
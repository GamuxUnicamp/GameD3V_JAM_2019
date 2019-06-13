extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$botoes/NewGameButton.connect("pressed",get_tree(),"change_scene",["res://Scenes/Cutscenes/Prologo/Prologo.tscn"])
	$botoes/QuitButton.connect("pressed",get_tree(),"quit")
	$botoes/ContinueButton.connect("pressed",global,"game_load")
	pass # Replace with function body.
#func sair():
#	get_tree().quit()
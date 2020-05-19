extends Control


func _ready():
	$botoes/NewGameButton.connect("pressed",get_tree(),"change_scene",["res://Scenes/Cutscenes/Prologo/Prologo.tscn"])
	$botoes/QuitButton.connect("pressed",get_tree(),"quit")
	$botoes/ContinueButton.connect("pressed",global,"game_load")
	pass 

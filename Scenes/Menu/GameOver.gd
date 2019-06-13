extends Control

func _ready():
	$botoes/MenuButton.connect("pressed",get_tree(),"change_scene",["res://Scenes/Menu/Menu.tscn"])
	pass 
extends Node2D


func _ready():
	$Player.connect("paradas_pra_ui",self,"ui_update")
	pass 

func ui_update(dados):
	$CanvasLayer/ProgressBar.max_value = dados["max_life"]
	$CanvasLayer/ProgressBar.value = dados["life"]
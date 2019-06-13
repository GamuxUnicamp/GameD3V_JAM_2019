extends Node2D


func _ready():
	$Player.connect("morri",self,"morreu")
	global.save_game("res://Scenes/Temp/LevelTest2.tscn")
	pass 

func morreu():
	global.reset_health()
	get_tree().change_scene("res://Scenes/Temp/LevelTest2.tscn")
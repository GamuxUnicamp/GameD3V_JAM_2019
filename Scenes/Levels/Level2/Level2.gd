extends Node2D

export var max_artifacts = 7

func _ready():
	
	$Actors/Player.connect("morri",self,"restart_level")
	
	#Controle de jogador 
	$Actors/Player.sob_controle = false
	
	#Fade in
	$FX.play("fade")
	$FX.set_speed_scale(1.3)
	
	yield($FX,"animation_finished")
	$FX.set_speed_scale(1)
	
	#Controle de jogador
	$Actors/Player.sob_controle = true
	
func restart_level():
	get_tree().change_scene("res://Scenes/Levels/Level2/Level2.tscn")

func change_level(body):
	
	if body.name == "Player":
			
		#Controle de jogador 
		$Actors/Player.sob_controle = false
	
		#Fade in
		$FX.play_backwards("fade")
		$FX.set_speed_scale(.5)
		
		yield($FX,"animation_finished")
		$FX.set_speed_scale(1)
		
		global.mission_artifacts = 0
		
		#Teste define final baseado no numero de arteftos do jogado
		if global.artifacts >= max_artifacts:
			get_tree().change_scene("res://Scenes/Cutscenes/Final_Abandono/Final_Abandono.tscn")
		else:
			get_tree().change_scene("res://Scenes/Cutscenes/Final_Decepcao/Final_Decepcao.tscn")
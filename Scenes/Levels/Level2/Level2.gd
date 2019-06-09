extends Node2D

func _ready():
	
	#Controle de jogador 
	$Player.sob_controle = false

	#Fade in
	$FX.play("fade")
	$FX.set_speed_scale(1.3)
	
	yield($FX,"animation_finished")
	$FX.set_speed_scale(1)
	
	#Controle de jogador
	$Player.sob_controle = true
	

func change_level(body):
	
	if body.name == "Player":
			
		#Controle de jogador 
		$Player.sob_controle = false
	
		#Fade in
		$FX.play_backwards("fade")
		$FX.set_speed_scale(.5)
		
		yield($FX,"animation_finished")
		$FX.set_speed_scale(1)
		
		get_tree().change_scene("res://Scenes/Temp/LevelTest2.tscn")
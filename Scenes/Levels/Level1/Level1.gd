extends Node2D

func game_over(coisa1,coisa2):
	$UI.queue_free()
	global.game_over(coisa1,coisa2)

func _ready():
	global.save_game("res://Scenes/Levels/Level1/Level1.tscn")
	
	$Actors/Player.connect("morri",self,"game_over",[$FX,$Actors/Player])
	
	#Controle de jogador 
	$Actors/Player.sob_controle = false

	#Fade in
	$FX.play("fade")
	$FX.set_speed_scale(.5)
	
	yield($FX,"animation_finished")
	$FX.set_speed_scale(1)
	
	#Controle de jogador
	$Actors/Player.sob_controle = true
	

	
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
		get_tree().change_scene("res://Scenes/Cutscenes/Intervalo/Intervalo.tscn")
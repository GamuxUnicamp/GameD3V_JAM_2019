extends Node2D

func _ready():
	
	$Player.connect("morri",self,"restart_level")
	
	#Controle de jogador 
	$Player.sob_controle = false
	
	#Fade in
	$FX.play("fade")
	$FX.set_speed_scale(1.3)
	
	yield($FX,"animation_finished")
	$FX.set_speed_scale(1)
	
	#Controle de jogador
	$Player.sob_controle = true
	
func restart_level():
	get_tree().change_scene("res://Scenes/Levels/Level2/Level2.tscn")

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
extends Node2D

func _ready():
	
	#Controle de jogador 
	$Player.sob_controle = false

	#Fade in
	$FX.play("fade")
	$FX.set_speed_scale(.5)
	
	yield($FX,"animation_finished")
	$FX.set_speed_scale(1)
	
	#Controle de jogador
	$Player.sob_controle = true
	

func change_level():
	pass
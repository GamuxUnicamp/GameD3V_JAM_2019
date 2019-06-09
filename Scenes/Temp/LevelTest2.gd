extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.connect("paradas_pra_ui",self,"ui_update")
	pass # Replace with function body.

func ui_update(dados):
	$CanvasLayer/ProgressBar.max_value = dados["max_life"]
	$CanvasLayer/ProgressBar.value = dados["life"]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends StaticBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player_in = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("body_entered",self,"entrou")
	$Area2D.connect("body_exited",self,"saiu")
	set_process(true)
	pass # Replace with function body.
func _process(delta):
	if Input.is_action_pressed("action1"):
		if player_in:
			self.quebrou()
	pass

func quebrou():
	#mostra animaçao 
	self.queue_free()
	
	pass
	
func entrou(algo):
	if algo.is_in_group("Player"):
		self.player_in = true
	pass
func saiu(algo):
	if algo.is_in_group("Player"):
		self.player_in = false
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

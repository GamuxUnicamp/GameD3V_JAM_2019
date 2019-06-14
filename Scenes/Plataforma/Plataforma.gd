extends KinematicBody2D
var movimento = false
var velocidade = Vector2(0,0)
var normal = Vector2(0,-1)

func _ready():
	add_to_group("Plataforma")
	set_physics_process(true)
	hide()
	pass 
func _physics_process(delta):
	if (movimento):
		print("Move")
		show()
		velocidade.y = 250
	else:
		velocidade.y = 0
	move_and_slide(velocidade,normal)
	pass


extends KinematicBody2D
var movimento = false
var velocidade = Vector2(0,0)
var normal = Vector2(0,-1)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Plataforma")
	set_physics_process(true)
	hide()
	pass # Replace with function body.
func _physics_process(delta):
	if (movimento):
		print("Move")
		show()
		velocidade.y = 250
	else:
		velocidade.y = 0
	move_and_slide(velocidade,normal)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

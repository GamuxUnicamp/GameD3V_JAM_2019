extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	if connect("body_entered",self,"parar") != 0:
		print("Failed to connect Signal")
	pass # Replace with function body.


func parar(body):
	if body.is_in_group("Plataforma"):
		print("Para")
		body.movimento = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

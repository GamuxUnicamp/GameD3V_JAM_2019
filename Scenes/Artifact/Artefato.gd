extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"entrou")
	pass # Replace with function body.

func entrou(body):
	if body.is_in_group("Player"):
		print("pegou artefato")
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

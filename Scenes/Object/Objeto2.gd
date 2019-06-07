extends StaticBody2D

# Declare member variables here. Examples:
# var a

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Quebravel")


func quebrou():
	#mostra animaçao
	get_parent().modulate.a = 0.5
	get_parent().add_to_group("Ignore")
	queue_free()

	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

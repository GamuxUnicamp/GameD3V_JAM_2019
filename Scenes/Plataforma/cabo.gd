extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	if connect("area_entered",self,"cortou") != 0:
		print("Failed to connect Signal")
	set_process(true)
	pass # Replace with function body.
func cortou(body):
	if body.is_in_group("arma"):
		if body.atacando:
			print("começa")
			get_parent().movimento = true
			queue_free()
	elif body.is_in_group("bolha"):
		print("começa")
		get_parent().movimento = true
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

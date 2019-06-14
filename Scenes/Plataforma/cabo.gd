extends Area2D


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
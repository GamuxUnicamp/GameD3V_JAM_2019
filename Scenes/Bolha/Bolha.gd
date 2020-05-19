extends Area2D


func _ready():
	connect("body_entered",self,"unlock_shoot")
	pass 

func unlock_shoot(body):
	if body.is_in_group("Player"):
		global.can_shoot = true
		queue_free()

func _process(delta):
	pass

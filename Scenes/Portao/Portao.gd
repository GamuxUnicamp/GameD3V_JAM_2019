extends StaticBody2D


export(int)var artifacts = 1

func _ready():
	$Area2D.connect("body_entered",self,"player_entered")
	pass 

func player_entered(body):
	if body.is_in_group("Player") and global.artifacts >= artifacts:
		queue_free()

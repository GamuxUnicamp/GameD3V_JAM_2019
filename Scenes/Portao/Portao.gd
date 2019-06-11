extends StaticBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int)var artifacts = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("body_entered",self,"player_entered")
	pass # Replace with function body.

func player_entered(body):
	if body.is_in_group("Player") and global.artifacts >= artifacts:
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

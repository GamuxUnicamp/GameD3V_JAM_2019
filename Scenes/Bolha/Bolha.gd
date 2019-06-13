extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"unlock_shoot")
	pass # Replace with function body.

func unlock_shoot(body):
	if body.is_in_group("Player"):
		global.can_shoot = true
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

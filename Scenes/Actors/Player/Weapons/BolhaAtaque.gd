extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(1,0)
export(String)var enemy = "Enemy"
export(String)var ally = "Player"
export(int)var damage = 15
var duration = 1.5
var acabou = false
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("bolha")
	if connect("body_entered",self,"bateu") != 0:
		print("Failed to connect Signal")
	if connect("area_entered",self,"bateu") != 0:
		print("Failed to connect Signal")
	get_tree().create_timer(duration).connect("timeout",self,"free_me")
	pass # Replace with function body.
	
func bateu(body):
	if not (body.is_in_group(ally) or body.is_in_group("Ignore")):
		if body.is_in_group("Quebravel"):
			if body.has_method("quebrou"):
				body.quebrou()
		if body.is_in_group(enemy):
			if body.has_method("damage"):
				body.damage(damage)
		free_me()
		
func free_me():
	if not acabou:
		$CollisionShape2D.queue_free()
		velocity = Vector2(0,0)
		$AnimationPlayer.play("Explodir")
		acabou = true
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position+=velocity*delta
#	pass

extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var can_attack = true
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	if $Cooldown.connect("timeout",self,"reloaded") != 0:
		print("Failed to connect Signal")
	if $Duration.connect("timeout",self,"attack_ended") != 0:
		print("Failed to connect Signal")
	if connect("body_entered",self,"bateu") != 0:
		print("Failed to connect Signal")
	pass # Replace with function body.
func bateu(body):
	if body.is_in_group("Enemy"):
		print("Bateu")

func reloaded():
	can_attack = true

func attack_ended():
	hide()
	$Shape.disabled = true
	$Cooldown.start()

func attack():
	if can_attack:
		show()
		$Shape.disabled = false
		$Duration.start()
		can_attack = false
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends StaticBody2D


# Declare member variables here. Examples:
# var a

# Called when the node enters the scene tree for the first time.
var heal = 0;

func _ready():
	add_to_group("Quebravel")
	var random = RandomNumberGenerator.new()
	random.randomize()
	heal = random.randi_range(1,3)


func quebrou(Player):
	#mostra animaçao
	Player.HP += heal
	if Player.HP > 5:
		Player.HP = 5
	get_parent().modulate.a = 0.5
	get_parent().add_to_group("Ignore")
	queue_free()

	pass
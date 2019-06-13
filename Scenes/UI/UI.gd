extends CanvasLayer

func _ready():
	pass 

func _process(delta):
	
	$Life/LifeBar.margin_right= (global.max_health * 100)
	
	$Life/LifeBar.max_value = global.max_health
	$Life/LifeBar.value = global.health
	$Artifact/ArtefatoLabel.text = str(global.artifacts)
	
	
	#Player_Death
	if $Life/LifeBar.value == 0:
		for c in get_children():
			c.hide()

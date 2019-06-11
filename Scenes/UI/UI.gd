extends CanvasLayer

func _ready():
	pass 

func _process(delta):
	$Life/LifeBar.max_value = global.max_health
	$Life/LifeBar.value = global.health
	$Artifact/ArtefatoLabel.text = str(global.artifacts)

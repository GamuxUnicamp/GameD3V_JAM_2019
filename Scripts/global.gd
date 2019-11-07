extends Node

var max_health = 5
var health = max_health
var artifacts = 0
var mission_artifacts = 0
var mission_health = 0
var cena_atual = ""
var can_shoot = false


func add_artifact():
	artifacts += 1
	mission_artifacts += 1

func reset_health():
	artifacts -= mission_artifacts
	mission_artifacts = 0
	max_health -= mission_health
	mission_health = 0
	health = max_health
	
func game_load():
	var content = ""
	var file = File.new()
	if file.file_exists("user://savegame.save"):
		file.open("user://savegame.save", file.READ)
		content = file.get_as_text()
		file.close()
	var dict = JSON.parse(content)
	if (dict.result):
		max_health = dict.result.max_health
		health = dict.result.health
		artifacts = dict.result.artifacts
		mission_artifacts = dict.result.mission_artifacts
		can_shoot = dict.result.can_shoot
		cena_atual = dict.result.cena_atual
		get_tree().change_scene(cena_atual)
	else:
		print("Error: wrong JSON format, Screwed up loser")
		return null
	pass

func save_game(cena): #user://savegame.save
	cena_atual = cena
	var save_dict = {
		"max_health" : max_health,
		"health" : health,
		"artifacts" : artifacts,
		"mission_artifacts" : mission_artifacts,
		"can_shoot" : can_shoot,
		"cena_atual" : cena_atual 
		}
	var save_game = File.new() #user://savegame.save
	if not save_game.file_exists("user://savegame.save"):
		save_game.open("user://savegame.save", File.WRITE)
	else:
		save_game.open("user://savegame.save", File.READ_WRITE)
	save_game.store_line(to_json(save_dict))
	save_game.close()
	return
	pass
	
func game_over(FX,Player):
	Player.set_process(false)
	FX.play_backwards("fade")
	FX.set_speed_scale(.5)
	yield(FX,"animation_finished")
	FX.set_speed_scale(1)
	global.reset_health()
	get_tree().change_scene("res://Scenes/Menu/GameOver.tscn")
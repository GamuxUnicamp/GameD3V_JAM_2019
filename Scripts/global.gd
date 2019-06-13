extends Node

var max_health = 5
var health = max_health
var artifacts = 0
var mission_artifacts = 0
var can_shoot = true

func add_artifact():
	artifacts += 1
	mission_artifacts += 1

func reset_health():
	artifacts -= mission_artifacts
	mission_artifacts = 0
	health = max_health
	
func game_load():
	pass
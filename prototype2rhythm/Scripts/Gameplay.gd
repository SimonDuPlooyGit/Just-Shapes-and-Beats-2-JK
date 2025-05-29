extends Node

func _ready():
	$Conductor.play_at_note(400)

func reset_game():
	var current_scene = get_tree().current_scene
	get_tree().reload_current_scene()

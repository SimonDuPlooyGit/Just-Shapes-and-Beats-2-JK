extends Node

func change_to_levels():
	get_tree().change_scene_to_file("res://Scenes/level_select.tscn")

func change_to_controls():
	get_tree().change_scene_to_file("res://Scenes/controls.tscn")

func quit_game():
	get_tree().quit()

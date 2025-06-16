extends Node

func what_the_duck():
	get_tree().change_scene_to_file("res://Scenes/BossFight.tscn")

func serenity():
	get_tree().change_scene_to_file("res://Scenes/SamuraiShamploo.tscn")

func return_to_menu():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

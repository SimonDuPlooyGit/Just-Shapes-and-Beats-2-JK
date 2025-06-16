extends Node

var paused = false
@onready var menu = $PauseMenu

func _ready():
	$Conductor.play_at_note(0)

func resume():
	get_tree().paused = false
	menu.visible = false

func pause():
	get_tree().paused = true
	menu.visible = true

func check_esc():
	if Input.is_action_just_pressed("Pause") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("Pause") and get_tree().paused == true:
		resume()

func return_to_menu():
	resume()
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _process(delta: float) -> void:
	check_esc()


func restart_level():
	resume()
	get_tree().reload_current_scene()

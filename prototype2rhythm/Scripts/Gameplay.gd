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

func restart_level():
	disable_pause_buttons()
	safe_reload_scene()

func return_to_menu():
	disable_pause_buttons()
	safe_return_to_menu()

func safe_reload_scene():
	var tree := get_tree()
	if tree == null: return
	var timer := tree.create_timer(0.01)
	timer.timeout.connect(_on_reload_timeout)

func _on_reload_timeout():
	if get_tree() == null: return
	get_tree().paused = false
	if is_instance_valid(menu):
		menu.visible = false
	get_tree().reload_current_scene()

func safe_return_to_menu():
	var tree := get_tree()
	if tree == null: return
	var timer := tree.create_timer(0.01)
	timer.timeout.connect(_on_return_timeout)

func _on_return_timeout():
	if get_tree() == null: return
	get_tree().paused = false
	if is_instance_valid(menu):
		menu.visible = false
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


func _process(delta: float) -> void:
	check_esc()

func disable_pause_buttons():
	$PauseMenu/Resume.disabled = true
	$PauseMenu/Restart.disabled = true
	$PauseMenu/Return.disabled = true

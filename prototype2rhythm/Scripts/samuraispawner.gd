extends Node

#Song variables
var bpm := 75
var notes_per_beat := 4
var beats_per_measure := 4
var sec_per_beat := 60.0 / bpm
var sec_per_note := sec_per_beat / notes_per_beat
var sec_per_measure := sec_per_beat * 4
var total_notes_per_measure := notes_per_beat * beats_per_measure

var current_measure = 0
var current_beat = 0
var current_note = 0

var spawning = false

var smallsamurai = preload("res://Scenes/samuraismall.tscn")
@onready var hitzones = $Hitzones
@onready var player = get_node("/root/node_2d/Player")


func update_measure(measure):
	current_measure = measure

var locations_to_spawn = ["top","right", "bottom", "left", "right", "left", "top", "bottom", "top", "top", "bottom",
"bottom", "left", "right", "left", "right", "left", "right", "left", "left", "right", "right", "top", "left", "right", "bottom",
"bottom"]

var location_index = 0
func update_beat(beat):
	current_beat = beat
	
	#print("Samurai spawner beat update!")
	
	var spawn_window_active = (
		(current_measure > 14 and current_measure < 20) or
		(current_measure == 14) or
		(current_measure == 20 and current_beat <= 3)
	)

	if current_measure >= 14 and current_measure < 21:
		hitzones.visible = true
	else:
		hitzones.visible = false

	if spawn_window_active and location_index < locations_to_spawn.size():
		var instance = smallsamurai.instantiate()
		get_tree().current_scene.add_child(instance)
		instance.slicing.connect(player.lose_life)
		
		match locations_to_spawn[location_index]:
			"top":
				instance.move_down()
			"bottom":
				instance.move_up()
			"left":
				instance.move_right()
			"right":
				instance.move_left()
		
		location_index += 1

func update_note(note):
	current_note = note

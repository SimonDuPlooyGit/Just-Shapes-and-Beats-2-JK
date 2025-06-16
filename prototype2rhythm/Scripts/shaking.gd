extends Camera2D

var shake_strength := 0.0
var shake_decay := 5.0
var original_offset := Vector2.ZERO

@export var bpm := 75
var notes_per_beat := 4
var beats_per_measure := 4
var sec_per_beat := 60.0 / bpm
var sec_per_note := sec_per_beat / notes_per_beat
var sec_per_measure := sec_per_beat * 4
var total_notes_per_measure := notes_per_beat * beats_per_measure

#Current information
var current_note = 0
var current_beat = 0
var current_measure = 0

var shake_strenghts_duck = {
	1: 3, #This one is for losing life
	measureToNote(32): 5,
}

var shake_strengths_samurai = {
	
}

func _ready():
	original_offset = offset

func _process(delta):
	print("Current shaking note:" + str(current_note))
	if shake_strenghts_duck.has(current_note) or shake_strengths_samurai.has(current_note):
		print("Shake on note!")
		start_shake(current_note)
	
	if shake_strength > 0:
		offset = original_offset + Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
		shake_strength = max(shake_strength - shake_decay * delta, 0)
	else:
		offset = original_offset

func start_shake(note):
	var strength
	print(get_tree().get_current_scene().name)
	if get_tree().get_current_scene().name == "DuckLevel":
		strength = shake_strenghts_duck.get(note)
	elif get_tree().get_current_scene().name == "SamuraiLevel":
		strength = shake_strengths_samurai.get(note)
	
	if strength == null:
		return
	else:
		shake_strength = strength

func measureUpdate(measure):
	current_measure = measure

func beatUpdate(beat):
	current_beat = beat

func noteUpdate(note):
	current_note = note

func beatToNote(beat, measure) -> int:
	return ((measure - 1) * beats_per_measure + (beat - 1)) * notes_per_beat

#Getting the note that a measure happens at
func measureToNote(measure) -> int:
	return (measure - 1) * total_notes_per_measure

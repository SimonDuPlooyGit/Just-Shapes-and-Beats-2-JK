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
	beatToNote(3,32): 1,
	beatToNote(1,33): 1,
	beatToNote(3,33): 1,
	beatToNote(1,34): 1,
	beatToNote(3,34): 1,
	beatToNote(1,35): 1,
	beatToNote(3,35): 1,
	beatToNote(1,36): 1,
	beatToNote(3,36): 1,
	beatToNote(1,37): 1,
	beatToNote(3,37): 1,
	beatToNote(1,38): 1,
	beatToNote(3,38): 1,
	beatToNote(1,39): 1,
	beatToNote(3,39): 1,
	beatToNote(1,40): 1,
	beatToNote(3,40): 1,
	beatToNote(1,41): 1,
	beatToNote(3,41): 1,
	beatToNote(1,42): 1,
	beatToNote(3,42): 1,
	beatToNote(1,43): 1,
	beatToNote(3,43): 1,
	beatToNote(1,44): 1,
	beatToNote(3,44): 1,
	beatToNote(1,45): 1,
	beatToNote(3,45): 1,
	beatToNote(1,46): 1,
	beatToNote(3,46): 1,
	beatToNote(1,47): 1,
	beatToNote(3,47): 1,
	beatToNote(1,48): 1,
	beatToNote(3,48): 1,
	beatToNote(1,49): 1,
	beatToNote(3,49): 1,
	beatToNote(1,50): 1,
	beatToNote(3,50): 1,
	beatToNote(1,51): 1,
	beatToNote(3,51): 1,
	beatToNote(1,52): 1,
	beatToNote(3,52): 1,
	beatToNote(1,53): 1,
	beatToNote(3,53): 1,
	beatToNote(1,54): 1,
	beatToNote(3,54): 1,
	beatToNote(1,55): 1,
	beatToNote(3,55): 1,
	beatToNote(1,56): 1,
	beatToNote(3,56): 1,
	beatToNote(1,57): 1,
	beatToNote(3,57): 1,
	beatToNote(1,58): 1,
	beatToNote(3,58): 1,
	beatToNote(1,59): 1,
	beatToNote(3,59): 1,
	beatToNote(1,60): 1,
	beatToNote(3,60): 1,
	beatToNote(1,61): 1,
	beatToNote(3,61): 1,
	beatToNote(1,62): 1,
	beatToNote(3,62): 1,
}

var shake_strengths_samurai = {
	beatToNote(4,13): 5,
	beatToNote(1,14): 1,
	beatToNote(2,14): 1,
	beatToNote(3,14): 1,
	beatToNote(4,14): 1,
	beatToNote(1,15): 1,
	beatToNote(2,15): 1,
	beatToNote(3,15): 1,
	beatToNote(4,15): 1,
	beatToNote(1,16): 1,
	beatToNote(2,16): 1,
	beatToNote(3,16): 1,
	beatToNote(4,16): 1,
	beatToNote(1,17): 1,
	beatToNote(2,17): 1,
	beatToNote(3,17): 1,
	beatToNote(4,17): 1,
	beatToNote(1,18): 1,
	beatToNote(2,18): 1,
	beatToNote(3,18): 1,
	beatToNote(4,18): 1,
	beatToNote(1,19): 1,
	beatToNote(2,19): 1,
	beatToNote(3,19): 1,
	beatToNote(4,19): 1,
	beatToNote(1,20): 1,
	beatToNote(2,20): 1,
	beatToNote(3,20): 1,
	332: 1,
	333: 1,
	334: 1,
	336: 1,
	337: 1,
	338: 1,
	340: 1,
	341: 1,
	342: 1,
	348: 1,
	349: 1,
	350: 1,
	352: 1,
	353: 1,
	354: 1,
	356: 1,
	357: 1,
	358: 1,
	364: 1,
	365: 1,
	366: 1,
	368: 1,
	369: 1,
	370: 1,
	372: 1,
	373: 1,
	374: 1,
	376: 1,
	377: 1,
	378: 1,
	380: 1,
	381: 1,
	382: 1,
	384: 1,
	385: 1,
	386: 1,
	387: 1,
	388: 1,
	389: 1,
	390: 1,
	391: 1,
}

func _ready():
	original_offset = offset

func _process(delta):
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

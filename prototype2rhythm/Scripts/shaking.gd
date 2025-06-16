extends Camera2D

var shake_strength := 0.0
var shake_decay := 5.0
var original_offset := Vector2.ZERO

var bpm := 75
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

var shake_strenghts = {
	1: 3 #This one is for losing life
}

func _ready():
	original_offset = offset

func _process(delta):
	
	
	
	if shake_strength > 0:
		offset = original_offset + Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
		shake_strength = max(shake_strength - shake_decay * delta, 0)
	else:
		offset = original_offset

func start_shake(note):
	var strength = shake_strenghts.get(note)
	
	if strength == null:
		return
	else:
		shake_strength = strength

func zoom_in():
	pass

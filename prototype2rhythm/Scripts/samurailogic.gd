extends Area2D

var current_measure = 0
var current_beat = 0
var current_note = 0

#Song variables
var bpm := 75
var notes_per_beat := 4
var beats_per_measure := 4
var sec_per_beat := 60.0 / bpm
var sec_per_note := sec_per_beat / notes_per_beat
var sec_per_measure := sec_per_beat * 4
var total_notes_per_measure := notes_per_beat * beats_per_measure

var small = false

func move():
	if (current_measure == 9):
		var tween = create_tween()
		tween.tween_property(self, "global_position:x", 1380, sec_per_beat*2)
	elif (current_measure == 12):
		var tween = create_tween()
		tween.tween_property(self, "global_position:x", 2460, sec_per_beat*2)

func move_up():
	self.global_position = Vector2(940,1110)
	var tween = create_tween()
	tween.tween_property(self, "global_position:y", 645, sec_per_beat*2)

func move_down():
	self.global_position = Vector2(970,-113)
	var tween = create_tween()
	tween.tween_property(self, "global_position:y", 378, sec_per_beat*2)

func move_left():
	self.global_position = Vector2(2030,515)
	var tween = create_tween()
	tween.tween_property(self, "global_position:x", 1155, sec_per_beat*2)

func move_right():
	self.global_position = Vector2(-106,515)
	var tween = create_tween()
	tween.tween_property(self, "global_position:x", 760, sec_per_beat*2)

func update_measure(measure):
	current_measure = measure

func update_beat(beat):
	current_beat = beat

func update_note(note):
	current_note = note
	move()

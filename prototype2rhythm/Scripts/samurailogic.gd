extends Area2D

var current_measure = 0
var current_beat = 0
var current_note = 0

var parryable = false
var parried = false
var parryKey = "nothing"

#Song variables
var bpm := 75
var notes_per_beat := 4
var beats_per_measure := 4
var sec_per_beat := 60.0 / bpm
var sec_per_note := sec_per_beat / notes_per_beat
var sec_per_measure := sec_per_beat * 4
var total_notes_per_measure := notes_per_beat * beats_per_measure

signal slicing()

func move():
	if (current_measure == 9):
		var tween = create_tween()
		tween.tween_property(self, "global_position:x", 1380, sec_per_beat*2)
	elif (current_measure == 12):
		var tween = create_tween()
		tween.tween_property(self, "global_position:x", 2460, sec_per_beat*2)

func slice():
	#emit_signal("slicing")
	pass

func move_up():
	parryKey = "Down"
	self.scale.x *= -1
	self.global_position = Vector2(940,1110)
	var tween = create_tween()
	tween.tween_property(self, "global_position:y", 645, sec_per_beat)
	await tween.finished
	await get_tree().create_timer(0.2).timeout
	slice()
	queue_free()

func move_down():
	parryKey = "Up"
	self.global_position = Vector2(970,-113)
	var tween = create_tween()
	tween.tween_property(self, "global_position:y", 378, sec_per_beat)
	await tween.finished
	await get_tree().create_timer(0.2).timeout
	slice()
	queue_free()

func move_left():
	parryKey = "Right"
	self.global_position = Vector2(2030,515)
	var tween = create_tween()
	tween.tween_property(self, "global_position:x", 1155, sec_per_beat)
	await tween.finished
	await get_tree().create_timer(0.2).timeout
	slice()
	queue_free()

func move_right():
	parryKey = "Left"
	self.scale.x *= -1
	self.global_position = Vector2(-106,515)
	var tween = create_tween()
	tween.tween_property(self, "global_position:x", 760, sec_per_beat)
	await tween.finished
	await get_tree().create_timer(0.2).timeout
	slice()
	queue_free()

func parry_checking():
	if self.global_position.distance_to(Vector2(960,560)) <= 270:
		parryable = true

func _unhandled_input(event):
	if parryKey == "nothing":
		return
	
	if event.is_action_pressed(parryKey) and parryable:
		parried = true
		#print("Parried! " + parryKey)
		queue_free()

func _process(delta: float) -> void:
	parry_checking()

func update_measure(measure):
	current_measure = measure

func update_beat(beat):
	current_beat = beat

func update_note(note):
	current_note = note
	move()

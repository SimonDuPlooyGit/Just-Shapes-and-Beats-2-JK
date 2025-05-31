extends AudioStreamPlayer2D

@export var bpm := 1
@export var notes_per_beat := 1 # n'th notes
@export var beats_per_measure := 1

# Derived values
var sec_per_beat := 60.0 / bpm
var sec_per_note := sec_per_beat / notes_per_beat
var total_notes_per_measure := notes_per_beat * beats_per_measure

# Tracking position
var song_position = 0.0
var song_position_in_notes = 0
var last_reported_note = -1
var measure = 1
var beat = 1
var note_in_beat = 1

# Signals
signal noteS(note)
signal beatS(beat)
signal measureS(measure)

func _ready():
	sec_per_beat = 60.0 / bpm
	sec_per_note = sec_per_beat / notes_per_beat
	#$ProgressBar.max_value = 328

func _physics_process(_delta):
	if playing:
		song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_position -= AudioServer.get_output_latency()
		song_position_in_notes = int(floor(song_position / sec_per_note))
		_report_note()
	
	#if song_position_in_notes == 328:
		#$Node2D.visible = true
		#$ProgressBar.visible = false
	
	#if song_position_in_notes == 393:
		#get_tree().quit()

func _report_note():
	if song_position_in_notes > last_reported_note:
		# Calculate current positions
		var current_note = song_position_in_notes
		var current_beat = int(current_note / notes_per_beat) % beats_per_measure + 1
		var current_measure = int(current_note / (beats_per_measure * notes_per_beat)) + 1
		
		var target_value = current_note
		#var tween = create_tween()
		#tween.tween_property($ProgressBar, "value", target_value, sec_per_note)

		# Emit signals
		emit_signal("noteS", current_note)
		print("Note: " + str(current_note) + "Beat: " + str(current_beat) + "Measure: " + str(current_measure))

		# Only emit beat and measure at the start of those cycles
		if current_note % notes_per_beat == 0:
			emit_signal("beatS", current_beat)
			$Tick.play()

		if current_note % total_notes_per_measure == 0:
			emit_signal("measureS", current_measure)

		last_reported_note = current_note

func play_at_note(num):
	self.play(num * sec_per_note)

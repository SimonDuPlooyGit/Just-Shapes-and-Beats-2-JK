extends Node

#Words
var STRANDED = preload("res://Words/stranded.tscn")
var IN = preload("res://Words/in.tscn")
var THE = preload("res://Words/the.tscn")
var OPEN = preload("res://Words/open.tscn")

var DRIED = preload("res://Words/dried.tscn")
var UP = preload("res://Words/up.tscn")
var TEARS = preload("res://Words/tears.tscn")
var OF = preload("res://Words/of.tscn")
var SORROW = preload("res://Words/sorrow.tscn")

var LACKING = preload("res://Words/lacking.tscn")
var ALL = preload("res://Words/all.tscn")
var EMOTION = preload("res://Words/emotion.tscn")

var TO = preload("res://Words/to.tscn")
var A = preload("res://Words/a.tscn")
var NEW = preload("res://Words/new.tscn")
var TOMORROW = preload("res://Words/tomorrow.tscn")

var BITCH = preload("res://Words/bitch.tscn")

signal shackle_player()
signal unshackle_player()

#Song variables
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

var wordOrder = {
	beatToNote(3,1): "spawnStranded",
	beatToNote(1,2): "spawnIn",
	beatToNote(2,2): "spawnThe",
	22: "spawnOpen",
	beatToNote(3,3): "spawnDried",
	beatToNote(4,3): "spawnUp",
	beatToNote(1,4): "spawnTears",
	beatToNote(2,4): "spawnOf",
	54: "spawnSorrow",
	beatToNote(3,5): "spawnLacking",
	beatToNote(1,6): "spawnAll",
	beatToNote(2,6): "spawnEmotion",
	beatToNote(3,7): "spawnTo",
	beatToNote(4,7): "spawnA",
	beatToNote(1,8): "spawnNew",
	beatToNote(2,8): "spawnTomorrow",
	beatToNote(3,12): "spawnStranded",
	beatToNote(1,13): "spawnIn",
	beatToNote(2,13): "spawnThe",
	202: "spawnBitch",
}

func _process(delta: float) -> void:
	pass

#Spawn a word to flow across the screen
func spawnWord(funcName):
	var word
	match funcName:
		"spawnStranded":
			word = STRANDED.instantiate()
			word.global_position = Vector2(1850,-315)
			word.set_rotation_angle(-30,"left")
		"spawnIn":
			word = IN.instantiate()
			word.global_position = Vector2(1910,-150)
			word.set_rotation_angle(-30,"left")
		"spawnThe":
			word = THE.instantiate()
			word.global_position = Vector2(2080,100)
			word.set_rotation_angle(-30,"left")
		"spawnOpen":
			word = OPEN.instantiate()
			word.global_position = Vector2(2150,215)
			word.set_rotation_angle(-30,"left")
		"spawnDried":
			word = DRIED.instantiate()
			word.global_position = Vector2(125,-265)
			word.set_rotation_angle(30,"right")
		"spawnUp":
			word = UP.instantiate()
			word.global_position = Vector2(60,-105)
			word.set_rotation_angle(30,"right")
		"spawnTears":
			word = TEARS.instantiate()
			word.global_position = Vector2(-250,-140)
			word.set_rotation_angle(30,"right")
		"spawnOf":
			word = OF.instantiate()
			word.global_position = Vector2(-120,200)
			word.set_rotation_angle(30,"right")
		"spawnSorrow":
			word = SORROW.instantiate()
			word.global_position = Vector2(-320,230)
			word.set_rotation_angle(30,"right")
		"spawnLacking":
			word = LACKING.instantiate()
			word.global_position = Vector2(1900,-350)
			word.set_rotation_angle(-30,"left")
		"spawnAll":
			word = ALL.instantiate()
			word.global_position = Vector2(2015,-160)
			word.set_rotation_angle(-30,"left")
		"spawnEmotion":
			word = EMOTION.instantiate()
			word.global_position = Vector2(2250,45)
			word.set_rotation_angle(-30,"left")
		"spawnTo":
			word = TO.instantiate()
			word.global_position = Vector2(160,-120)
			word.set_rotation_angle(30,"right")
		"spawnA":
			word = A.instantiate()
			word.global_position = Vector2(-55,-55)
			word.set_rotation_angle(30,"right")
		"spawnNew":
			word = NEW.instantiate()
			word.global_position = Vector2(-160,85)
			word.set_rotation_angle(30,"right")
		"spawnTomorrow":
			word = TOMORROW.instantiate()
			word.global_position = Vector2(-400,115)
			word.set_rotation_angle(30,"right")
		"spawnBitch":
			word = BITCH.instantiate()
			word.global_position = Vector2(960,100)
		
	get_tree().current_scene.add_child(word)

#Updating current_measure with the measureS from conductor
func measureUpdate(measure):
	current_measure = measure
	
	if current_measure == 21:
		emit_signal("unshackle_player")

#Updating current_beat with the beatS from conductor
func beatUpdate(beat):
	current_beat = beat

#Updating current_note with the noteS from conductor
func noteUpdate(note):
	current_note = note
	
	if current_note == 202:
		emit_signal("shackle_player")
	
	if wordOrder.has(current_note):
		var func_name = wordOrder[current_note]
		spawnWord(func_name)

#Getting the note that a beat happens at
func beatToNote(beat, measure) -> int:
	return ((measure - 1) * beats_per_measure + (beat - 1)) * notes_per_beat

#Getting the note that a measure happens at
func measureToNote(measure) -> int:
	return (measure - 1) * total_notes_per_measure

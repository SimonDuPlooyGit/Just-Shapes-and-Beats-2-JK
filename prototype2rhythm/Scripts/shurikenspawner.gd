extends Node

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

@onready var shuriken = preload("res://Scenes/shuriken.tscn")
@onready var player = get_node("/root/SamuraiLevel/Player")

var locations = {
	1: Vector2(64, -64),
	2: Vector2(192, -64),
	3: Vector2(320, -64),
	4: Vector2(448, -64),
	5: Vector2(576, -64),
	6: Vector2(704, -64),
	7: Vector2(832, -64),
	8: Vector2(960, -64),
	9: Vector2(1088, -64),
	10: Vector2(1216, -64),
	11: Vector2(1344, -64),
	12: Vector2(1472, -64),
	13: Vector2(1600, -64),
	14: Vector2(1728, -64),
	15: Vector2(1856, -64),
	16: Vector2(1984, 64),
	17: Vector2(1984, 192),
	18: Vector2(1984, 320),
	19: Vector2(1984, 448),
	20: Vector2(1984, 576),
	21: Vector2(1984, 704),
	22: Vector2(1984, 832),
	23: Vector2(1984, 960),
}

var spawnNotes = {
	332: 1,
	333: 2,
	334: 3,
	336: 4,
	337: 5,
	338: 6,
	340: 7,
	341: 8,
	342: 9,
	348: 10,
	349: 11,
	350: 12,
	352: 13,
	353: 14,
	354: 15,
	356: 16,
	357: 17,
	358: 18,
	364: 19,
	365: 20,
	366: 21,
	368: 22,
	369: 23,
	370: 22,
	372: 21,
	373: 20,
	374: 19,
	376: 18,
	377: 17,
	378: 16,
	380: 15,
	381: 14,
	382: 13,
	384: 12,
	385: 11,
	386: 10,
	387: 9,
	388: 8,
	389: 7,
	390: 6,
	391: 5,
}

func spawn():
	if spawnNotes.has(current_note):
		var loc_index = spawnNotes[current_note]
		var spawn_pos = locations.get(loc_index, Vector2.ZERO)
		
		var instance = shuriken.instantiate()
		instance.global_position = spawn_pos
		get_tree().current_scene.add_child(instance)
		
		var direction = (player.global_position - spawn_pos).normalized()
		instance.direction = direction

func update_measure(measure):
	current_measure = measure

func update_beat(beat):
	current_beat = beat

func update_note(note):
	current_note = note
	spawn()

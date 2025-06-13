extends Node

var current_note = 0
var current_beat = 0
var current_measure = 0

@onready var slashes = [
	$Swordslash, $Swordslash2, $Swordslash3, $Swordslash4,
	$Swordslash5, $Swordslash6, $Swordslash7, $Swordslash8,
	$Swordslash9, $Swordslash10, $Swordslash11, $Swordslash12,
	$Swordslash13, $Swordslash14, $Swordslash15, $Swordslash16,
	$Swordslash17, $Swordslash18, $Swordslash19, $Swordslash20,
	$Swordslash21, $Swordslash22, $Swordslash23, $Swordslash24,
]

func update_measure(measure):
	current_measure = measure

func update_beat(beat):
	current_beat = beat

var slash_index = 0
func update_note(note):
	current_note = note

	if current_note % 2 == 0 \
	and ((current_measure == 9 and current_beat >= 3) or current_measure > 9) \
	and slash_index < slashes.size():

		# Control visibility in groups
		if slash_index == 6:
			# Hide slashes 0–5 before showing 6
			for i in range(0, 6):
				slashes[i].visible = false

		if slash_index == 16:
			# Hide slashes 6–15 before showing 16
			for i in range(6, 16):
				slashes[i].visible = false
		
		# Show current slash
		slashes[slash_index].visible = true
		slash_index += 1
		
		# Hide final group (16–23) after showing last one
		if slash_index == 24:
			for i in range(16, 24):
				slashes[i].visible = false

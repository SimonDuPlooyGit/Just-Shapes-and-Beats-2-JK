extends Camera2D

var shake_strength := 0.0
var shake_decay := 5.0
var original_offset := Vector2.ZERO

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

var shake_strenghts = {
	2: 5,
	6: 5,
	18: 5,
	19: 5,
	20: 5,
	22: 3,
	23: 3,
	24: 3,
	26: 5,
	28: 3,
	30: 5,
	32: 3,
	33: 3,
	34: 5,
	36: 3,
	38: 3,
}

func start_shake(measure):
	var strength = shake_strenghts.get(measure)
	
	if strength == null:
		return
	else:
		shake_strength = strength

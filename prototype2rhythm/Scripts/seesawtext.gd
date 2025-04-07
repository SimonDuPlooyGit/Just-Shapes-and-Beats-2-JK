extends Node2D

@export var seesaw_speed: float = 2.0
@export var seesaw_range: float = 15.0

func _ready():
	# Center the label on this node
	var label = $Endtext
	label.position = -label.get_size() / 2

func _process(delta):
	var angle = sin(Time.get_ticks_msec() / 1000.0 * seesaw_speed) * seesaw_range
	rotation_degrees = angle

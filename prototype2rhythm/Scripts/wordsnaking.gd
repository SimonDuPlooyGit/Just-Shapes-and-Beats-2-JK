extends Node2D

#=== WAVE SETTINGS ===
@export var wave_amplitude: float = 20.0
@export var wave_frequency: float = 2.0
@export var wave_speed: float = 2.0
@export var phase_offset: float = 0.5

#=== MICRO WAVE SETTINGS ===
@export var micro_wave_amplitude: float = 5.0
@export var micro_wave_frequency: float = 6.0
@export var micro_wave_enabled: bool = true

#=== MOVEMENT SETTINGS ===
@export var move_speed: float = 100.0 # pixels per second
var move_direction: Vector2 = Vector2.RIGHT

#=== INTERNAL STATE ===
var time_passed := 0.0
var letter_offsets := []

func _ready():
	#Store initial local positions of each letter
	for child in get_children():
		if child is Area2D:
			letter_offsets.append(child.position)

func _process(delta: float) -> void:
	time_passed += delta
	
	#Move the root node along the movement direction
	position += move_direction.normalized() * move_speed * delta
	
	#Calculate a perpendicular vector for wave offset
	var wave_axis = Vector2(-move_direction.y, move_direction.x).normalized()

	#Animate each letter along the wave axis
	for i in get_child_count():
		var letter = get_child(i)
		if not (letter is Area2D):
			continue
		
		var base_pos = letter_offsets[i]
		
		var wave_offset = wave_amplitude * sin((time_passed * wave_speed) + (i * phase_offset) * wave_frequency)
		
		var micro_wave_offset = 0.0
		if micro_wave_enabled:
			micro_wave_offset = micro_wave_amplitude * sin((time_passed * wave_speed * 2.0) + i)
		
		#Final wave movement
		var final_offset = (wave_offset + micro_wave_offset) * wave_axis
		letter.position = base_pos + final_offset

#Sets the angle in degrees and rotates the node accordingly
func set_rotation_angle(angle_degrees: float, direction: String) -> void:
	rotation_degrees = angle_degrees
	move_direction = Vector2.RIGHT.rotated(deg_to_rad(angle_degrees))
	
	if direction == "left":
		move_direction *= -1

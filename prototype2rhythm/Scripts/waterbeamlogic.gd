extends Area2D

@onready var sprite := $Sprite2D
@onready var collision_shape := $CollisionShape2D

@export var telegraph_time := 0.0 # Time before activation
@export var active_time := 0.0    # Time it stays active
@export var direction := ""       # "up", "down", "left", "right"

var has_damaged_player := false
var overlap_body

@onready var telegraph_timer := Timer.new()
@onready var active_timer := Timer.new()

func _ready() -> void:
	# Direction-based rotation
	match direction:
		"left":
			pass
		"right":
			pass
		"up":
			rotation_degrees = 90
		"down":
			pass
	
	# Initial state: faint and inactive
	modulate.a = 0.3
	collision_shape.disabled = true

	# Add and configure timers
	telegraph_timer.wait_time = telegraph_time
	telegraph_timer.one_shot = true
	telegraph_timer.process_mode = Node.PROCESS_MODE_PAUSABLE
	add_child(telegraph_timer)

	active_timer.wait_time = active_time
	active_timer.one_shot = true
	active_timer.process_mode = Node.PROCESS_MODE_PAUSABLE
	add_child(active_timer)

	# Start telegraphing
	telegraph_timer.start()
	await telegraph_timer.timeout

	# Beam becomes active
	modulate.a = 1.0
	collision_shape.disabled = false

	# Start duration before removal
	active_timer.start()
	await active_timer.timeout
	queue_free()

func _process(delta: float) -> void:
	if has_overlapping_bodies() and not has_damaged_player:
		overlap_body = get_overlapping_bodies()
		for body in overlap_body:
			if body.name == "Player":
				body.lose_life()
				has_damaged_player = true

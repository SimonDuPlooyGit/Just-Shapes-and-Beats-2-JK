extends Area2D

@onready var sprite := $Sprite2D
@onready var collision_shape := $CollisionShape2D

var telegraph_time := 0.0 # Time in seconds before it becomes active
var input_dir = ""
var direction = 0
@export var speed = 600

func _ready() -> void:
	# Initial state: invisible and harmless
	modulate.a = 0.3
	collision_shape.disabled = true

	# Wait for telegraph period
	await get_tree().create_timer(telegraph_time).timeout

	# Activate: full opacity and enable collision
	modulate.a = 1.0
	collision_shape.disabled = false
	
	if (input_dir == "down"):
		direction = 1
	else:
		direction = -1

func _process(delta: float) -> void:
	
	position.y += speed * direction * delta
	
	if (self.position.x > 1920 || self.position.x < 0):
		queue_free()
	elif (self.position.y > 1080 || self.position.y < 0):
		queue_free()

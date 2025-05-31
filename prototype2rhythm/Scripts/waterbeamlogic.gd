extends Area2D

@onready var sprite := $Sprite2D
@onready var collision_shape := $CollisionShape2D

var telegraph_time := 0.0 # Time in seconds before it becomes active
var active_time := 0.0 #Time in seconds where it shows on screen
var direction := ""

func _ready() -> void:
	
	match direction:
		"left":
			pass
		"right":
			pass
		"up":
			rotation_degrees = 90
		"down":
			pass
	
	# Initial state: invisible and harmless
	modulate.a = 0.3
	collision_shape.disabled = true

	# Wait for telegraph period
	await get_tree().create_timer(telegraph_time).timeout

	# Activate: full opacity and enable collision
	modulate.a = 1.0
	collision_shape.disabled = false

	# Optional: Auto-delete after some time
	await get_tree().create_timer(active_time).timeout
	queue_free()

# Called when something enters the area
func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		print("Player hit by water beam!")

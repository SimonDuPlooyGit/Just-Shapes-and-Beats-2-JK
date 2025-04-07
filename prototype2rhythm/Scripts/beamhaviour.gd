extends AnimatableBody2D

var sec_per_note := 60.0 / 140.0 / 2.0
var timer := 0.0

# These should be declared at the top level
@onready var sprite := $Sprite2D
@onready var collision_shape := $CollisionShape2D

func _ready() -> void:
	# Start as a transparent warning and disable collision
	sprite.modulate.a = 0.3
	collision_shape.disabled = true

func _process(delta: float) -> void:
	timer += delta

	if timer >= sec_per_note * 8 and timer < sec_per_note * 12:
		# Activate: opaque and collidable
		sprite.modulate.a = 1.0
		collision_shape.disabled = false
	elif timer >= sec_per_note * 12:
		# Deactivate and remove the beam
		queue_free()

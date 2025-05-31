extends Node

@onready var sprite := $Sprite2D
@onready var collision_shape := $CollisionShape2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	await get_tree().create_timer(0.6).timeout
	queue_free()

func _on_body_entered(body):
	if body.name == "Player":  # or use groups or class_name
		print("Player hit by water beam!")
		# Handle damage or effects here

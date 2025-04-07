extends Area2D

var sec_per_note := 60.0 / 140.0 / 2.0
var timer := 0.0
@export var speed = 600
var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var has_shot = false
var overlap_body
var has_damaged_player := false

@onready var sprite := $Sprite2D
@onready var collision_shape := $CollisionShape2D

func _ready() -> void:
	# Start as a transparent warning and disable collision
	sprite.modulate.a = 0.3
	collision_shape.disabled = true

func setup(dir: Vector2):
	direction = dir

func shoot(direction: Vector2):
	velocity = direction.normalized() * speed

func _process(delta: float) -> void:
	timer += delta
	self.position += velocity * delta
	
	if has_overlapping_bodies() and not has_damaged_player:
		overlap_body = self.get_overlapping_bodies()
		for body in overlap_body:
			if body.name == "Player":
				#body.queue_free()
				body.lose_life()
				has_damaged_player = true
				pass
	
	if timer >= sec_per_note * 8 and timer < sec_per_note * 12 and not has_shot:
		# Activate: opaque and collidable
		sprite.modulate.a = 1.0
		collision_shape.disabled = false
		shoot(direction)
		has_shot = true
	elif timer >= sec_per_note * 12:
		if (self.position.x > 1920 || self.position.x < 0):
			queue_free()
		elif (self.position.y > 1080 || self.position.y < 0):
			queue_free()

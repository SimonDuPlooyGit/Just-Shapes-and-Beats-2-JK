extends Area2D

var bpm := 75
var sec_per_beat := 60.0 / bpm

var overlap_body
var has_damaged_player = false

@onready var collider = $CollisionShape2D
@onready var sprite = $Sprite2D

func _ready() -> void:
	sprite.scale.x = 0
	collider.disabled = true
	connect("visibility_changed", Callable(self, "_on_visibility_changed"))

func _on_visibility_changed():
	if visible:
		var tween = create_tween()
		tween.tween_property(sprite, "scale:x", 1, sec_per_beat / 16)
		tween.tween_callback(Callable(self, "_enable_collider"))
	elif !visible:
		collider.disabled = true

func _enable_collider():
	collider.disabled = false

func _process(delta: float) -> void:
	if has_overlapping_bodies() and not has_damaged_player:
		overlap_body = self.get_overlapping_bodies()
		for body in overlap_body:
			if body.name == "Player":
				body.lose_life()
				has_damaged_player = true

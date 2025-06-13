extends Area2D

# Song variables
var bpm := 75
var sec_per_beat := 60.0 / bpm

func _ready() -> void:
	scale.x = 0
	connect("visibility_changed", Callable(self, "_on_visibility_changed"))

func _on_visibility_changed():
	if visible:
		var tween = create_tween()
		tween.tween_property(self, "scale:x", 1, sec_per_beat / 16)

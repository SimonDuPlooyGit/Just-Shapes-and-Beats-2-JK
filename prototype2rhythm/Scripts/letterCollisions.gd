extends Area2D

var overlap_body
var has_damaged_player = false

func _process(delta: float) -> void:
	#Collision with player to lose lives
	if has_overlapping_bodies() and not has_damaged_player:
		overlap_body = self.get_overlapping_bodies()
		for body in overlap_body:
			if body.name == "Player":
				#body.queue_free()
				body.lose_life()
				has_damaged_player = true
				pass

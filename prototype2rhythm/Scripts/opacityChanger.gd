extends CanvasLayer

@onready var top = $Top
@onready var bottom = $Bottom
@onready var left = $Left
@onready var right = $Right

var light_up = Color(1,1,1,0.6)
var light_down = Color(1,1,1,0.25)

var lit_up = false

func change_opacity():
	if not lit_up:
		top.color = light_up
		bottom.color = light_up
		left.color = light_up
		right.color = light_up
		lit_up = true
	else:
		top.color = light_down
		bottom.color = light_down
		left.color = light_down
		right.color = light_down
		lit_up = false

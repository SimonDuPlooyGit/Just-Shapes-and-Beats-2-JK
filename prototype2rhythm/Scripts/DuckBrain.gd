extends AnimatedSprite2D

@onready var spawn_spot = $SpawnSpot
var waterbeam = preload("res://Scenes/water_beam.tscn")

var current_note = 0;
var current_beat = 0;
var current_measure = 0;
var facing_right = false;
var teleport_index = 0;

var initialQuacks = [117,118,120,122,123,124,126,133,134,136,138,139,140,142,
149,150,152,154,155,156,158,160,162,164,166,168,169,170,171,172,174,175, 181,
182,184,186,187,188,190,197,198,200,202,203,204,206,213,214,216,218,219,220,
222,224,226,227,228,230,232,233,234,235,236,237,238]

var buildupTeleportYs = [180,300,420,540,660,900,780,660,540,420,180,300,420,
540,660,900,780,660,540,420,180,300,420,540]

var buildupBeamYs = []

func _ready() -> void:
	var y_diff = self.global_position.y - spawn_spot.global_position.y
	
	# Adjust each teleport Y value by subtracting the Y difference
	for y in buildupTeleportYs:
		buildupBeamYs.append(y - y_diff)
	
	# Optional: print to verify
	print("Adjusted beam Y values: ", buildupBeamYs)
	
	teleport_index = 0
	swoopInBig()

func shootBeam():
	var beam_instance = waterbeam.instantiate()
	beam_instance.global_position = spawn_spot.global_position
	get_tree().current_scene.add_child(beam_instance)

func flipSprite():
	self.scale.x *= -1
	facing_right = !facing_right

func moveSideways(xCoord, duration):
	var tween = create_tween()
	tween.tween_property(self, "position:x", xCoord, duration)

func moveVertically(yCoord, duration):
	var tween = create_tween()
	tween.tween_property(self, "position:y", yCoord, duration)

func teleport(xCoord, yCoord, lookingWhere):
	var fade_out = create_tween()
	fade_out.tween_property(self, "modulate:a", 0.0, 0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	await fade_out.finished

	# Move and flip
	position = Vector2(xCoord, yCoord)
	if lookingWhere == "left" and facing_right:
		flipSprite()
	elif lookingWhere == "right" and not facing_right:
		flipSprite()

	var fade_in = create_tween()
	fade_in.tween_property(self, "modulate:a", 1.0, 0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	await fade_in.finished


func swoopInBig():
	var tween = create_tween()
	tween.set_parallel(true)

	#Swoop in big
	position.x = 1000
	tween.tween_property(self, "position:x", 1700, 1.0)
	position.y = 350
	tween.tween_property(self, "position:y", 530, 1.0)
	scale.x = 0.07
	tween.tween_property(self, "scale:x", 0.5, 1.0)
	scale.y = 0.07
	tween.tween_property(self, "scale:y", 0.5, 1.0)

	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	
	await tween.finished
	settleToNormal()

func settleToNormal():
	var tween = create_tween()
	tween.set_parallel(true)
	
	#Become smaller
	tween.tween_property(self, "scale:x", 0.3, 3.5)
	tween.tween_property(self, "scale:y", 0.3, 3.5)
	
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)

func duckNoteUpdate(note):
	current_note = note;
	
	#Move down
	if (note == 48):
		moveVertically(900,6.4)
	
	#Initial quacks
	if (initialQuacks.has(current_note)):
		play("Quack")
	
	#Flip left side and move up
	if (note == 292):
		flipSprite()
		moveVertically(190,4.8)
	
	#Flip right side
	if (note == 360):
		flipSprite()
	
	#Drop quack
	if (current_note == 493):
		play("DropQuack")

func duckBeatUpdate(beat):
	current_beat = beat;
	
	#Buildup
	if (current_measure >= 24 && current_measure <= 29):
		shootBeam()
		play("QuackSlower")
		teleport(1700,buildupTeleportYs[teleport_index],"left")
		teleport_index += 1

func duckMeasureUpdate(measure):
	current_measure = measure;
	
	#Laughs
	if (current_measure == 18):
		play("Laugh")
		moveSideways(230,1)
	
	if (current_measure == 22):
		play("Laugh")
		moveSideways(1700,1)
	
	#Drop
	if (current_measure == 32):
		play("Enraged")

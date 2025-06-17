extends AnimatedSprite2D

var waterbeam = preload("res://Scenes/water_beam.tscn")
var droplet = preload("res://Scenes/droplet.tscn")

#Song info for calcs
var bpm := 150
var notes_per_beat := 4
var beats_per_measure := 4
var sec_per_beat := 60.0 / bpm
var sec_per_note := sec_per_beat / notes_per_beat
var sec_per_measure := sec_per_beat * 4
var total_notes_per_measure := notes_per_beat * beats_per_measure

@onready var spawn = $StreamSpawn

#Spinning variables
@export var center_position := Vector2(960,540)
@export var radius_x := 1000
@export var radius_y := 400
@export var angular_speed := 0.5  # Radians per second
@export var angle_offset := -30 #Degrees
var spinning := false
var angle := 0.0

#Current information
var current_note = 0
var current_beat = 0
var current_measure = 0
var teleport_index = 0
var initial_scale = 0

#Initial setup of duck
func _ready() -> void:
	initial_scale = self.scale
	teleport_index = 0
	swoopInBig()

#Obstacle according to note library
var obstacle_schedule = {

# Droplets for quacks
117: [["spawnDroplet", Vector2(100,0), "down"]],
118: [["spawnDroplet", Vector2(360,0), "down"]],
120: [["spawnDroplet", Vector2(600,0), "down"]],
122: [["spawnDroplet", Vector2(840,0), "down"]],
123: [["spawnDroplet", Vector2(1080,0), "down"]],
124: [["spawnDroplet", Vector2(1320,0), "down"]],
126: [["spawnDroplet", Vector2(1560,0), "down"]],
133: [["spawnDroplet", Vector2(1800,0), "down"]],
134: [["spawnDroplet", Vector2(1560,0), "down"]],
136: [["spawnDroplet", Vector2(1320,0), "down"]],
138: [["spawnDroplet", Vector2(1080,0), "down"]],
139: [["spawnDroplet", Vector2(840,0), "down"]],
140: [["spawnDroplet", Vector2(600,0), "down"]],
142: [["spawnDroplet", Vector2(360,0), "down"]],
149: [["spawnDroplet", Vector2(100,0), "down"]],
150: [["spawnDroplet", Vector2(360,0), "down"]],
152: [["spawnDroplet", Vector2(600,0), "down"]],
154: [["spawnDroplet", Vector2(840,0), "down"]],
155: [["spawnDroplet", Vector2(1080,0), "down"]],
156: [["spawnDroplet", Vector2(1320,0), "down"]],
158: [["spawnDroplet", Vector2(1560,0), "down"]],
160: [["spawnDroplet", Vector2(1800,0), "down"]],
162: [["spawnDroplet", Vector2(1560,0), "down"]],
164: [["spawnDroplet", Vector2(1320,0), "down"]],
166: [["spawnDroplet", Vector2(1080,0), "down"]],
168: [["spawnDroplet", Vector2(840,0), "down"]],
169: [["spawnDroplet", Vector2(600,0), "down"]],
170: [["spawnDroplet", Vector2(360,0), "down"]],
171: [["spawnDroplet", Vector2(100,0), "down"]],
172: [["spawnDroplet", Vector2(360,0), "down"]],
174: [["spawnDroplet", Vector2(600,0), "down"]],
175: [["spawnDroplet", Vector2(840,0), "down"]],
181: [["spawnDroplet", Vector2(1080,0), "down"]],
182: [["spawnDroplet", Vector2(1320,0), "down"]],
184: [["spawnDroplet", Vector2(1560,0), "down"]],
186: [["spawnDroplet", Vector2(1800,0), "down"]],
187: [["spawnDroplet", Vector2(1560,0), "down"]],
188: [["spawnDroplet", Vector2(1320,0), "down"]],
190: [["spawnDroplet", Vector2(1080,0), "down"]],
197: [["spawnDroplet", Vector2(840,0), "down"]],
198: [["spawnDroplet", Vector2(600,0), "down"]],
200: [["spawnDroplet", Vector2(360,0), "down"]],
202: [["spawnDroplet", Vector2(100,0), "down"]],
203: [["spawnDroplet", Vector2(360,0), "down"]],
204: [["spawnDroplet", Vector2(600,0), "down"]],
206: [["spawnDroplet", Vector2(840,0), "down"]],
213: [["spawnDroplet", Vector2(1080,0), "down"]],
214: [["spawnDroplet", Vector2(1320,0), "down"]],
216: [["spawnDroplet", Vector2(1560,0), "down"]],
218: [["spawnDroplet", Vector2(1800,0), "down"]],
219: [["spawnDroplet", Vector2(1560,0), "down"]],
220: [["spawnDroplet", Vector2(1320,0), "down"]],
222: [["spawnDroplet", Vector2(1080,0), "down"]],
224: [["spawnDroplet", Vector2(840,0), "down"]],
226: [["spawnDroplet", Vector2(600,0), "down"]],
227: [["spawnDroplet", Vector2(360,0), "down"]],
228: [["spawnDroplet", Vector2(100,0), "down"]],
230: [["spawnDroplet", Vector2(360,0), "down"]],
232: [["spawnDroplet", Vector2(600,0), "down"]],
233: [["spawnDroplet", Vector2(840,0), "down"]],
234: [["spawnDroplet", Vector2(1080,0), "down"]],
235: [["spawnDroplet", Vector2(1320,0), "down"]],
236: [["spawnDroplet", Vector2(1560,0), "down"]],
237: [["spawnDroplet", Vector2(1800,0), "down"]],
238: [["spawnDroplet", Vector2(1560,0), "down"]],

# Beamshooting for buildup
beatToNote(1, 24): [["shootBeam", Vector2(1700,65), "left"]],
beatToNote(2, 24): [["shootBeam", Vector2(1700,185), "left"]],
beatToNote(3, 24): [["shootBeam", Vector2(1700,305), "left"]],
beatToNote(4, 24): [["shootBeam", Vector2(1700,425), "left"]],
beatToNote(1, 25): [["shootBeam", Vector2(1700,545), "left"]],
beatToNote(2, 25): [["shootBeam", Vector2(1700,665), "left"]],
beatToNote(3, 25): [["shootBeam", Vector2(1700,785), "left"]],
beatToNote(4, 25): [["shootBeam", Vector2(1700,905), "left"]],
beatToNote(1, 26): [["shootBeam", Vector2(1850,1080), "up"]],
beatToNote(2, 26): [["shootBeam", Vector2(1720,1080), "up"]],
beatToNote(3, 26): [["shootBeam", Vector2(1590,1080), "up"]],
beatToNote(4, 26): [["shootBeam", Vector2(1460,1080), "up"]],
beatToNote(1, 27): [["shootBeam", Vector2(1330,1080), "up"]],
beatToNote(2, 27): [["shootBeam", Vector2(1200,1080), "up"]],
beatToNote(3, 27): [["shootBeam", Vector2(1070,1080), "up"]],
beatToNote(4, 27): [["shootBeam", Vector2(940,1080), "up"]],
beatToNote(1, 28): [["shootBeam", Vector2(810,1080), "up"]],
beatToNote(2, 28): [["shootBeam", Vector2(680,1080), "up"]],
beatToNote(3, 28): [["shootBeam", Vector2(550,1080), "up"]],
beatToNote(4, 28): [["shootBeam", Vector2(420,1080), "up"]],
beatToNote(1, 29): [["shootBeam", Vector2(290,1080), "up"]],
beatToNote(2, 29): [["shootBeam", Vector2(1700,545), "left"]],
beatToNote(3, 29): [["shootBeam", Vector2(1700,425), "left"]],
beatToNote(4, 29): [["shootBeam", Vector2(1700,665), "left"]],


#Bass hit obstacles in drop section
beatToNote(1,32): [
["spawnDroplet", Vector2(100,0), "down"],
["spawnDroplet", Vector2(1800,1080), "up"],
],
beatToNote(3,32): [
["spawnDroplet", Vector2(360,0), "down"],
["spawnDroplet", Vector2(1560,1080), "up"],
],
beatToNote(1,33): [
["spawnDroplet", Vector2(600,0), "down"],
["spawnDroplet", Vector2(1320,1080), "up"],
],
beatToNote(3,33): [
["spawnDroplet", Vector2(840,0), "down"],
["spawnDroplet", Vector2(1080,1080), "up"],
],
beatToNote(1,34): [
["spawnDroplet", Vector2(1920,65), "left"],
["spawnDroplet", Vector2(0,1025), "right"],
],
beatToNote(3,34): [
["spawnDroplet", Vector2(1920,185), "left"],
["spawnDroplet", Vector2(0,905), "right"],
],
beatToNote(1,35): [
["spawnDroplet", Vector2(1920,305), "left"],
["spawnDroplet", Vector2(0,785), "right"],
],
beatToNote(3,35): [
["spawnDroplet", Vector2(1920,425), "left"],
["spawnDroplet", Vector2(0,665), "right"],
],
beatToNote(1,36): [
["spawnDroplet", Vector2(1920,665), "left"],
["spawnDroplet", Vector2(0,665), "right"],
],
beatToNote(1,32): [
["spawnDroplet", Vector2(100,0), "down"],
["spawnDroplet", Vector2(1800,1080), "up"],
],
beatToNote(3,32): [
["spawnDroplet", Vector2(360,0), "down"],
["spawnDroplet", Vector2(1560,1080), "up"],
],
beatToNote(1,33): [
["spawnDroplet", Vector2(600,0), "down"],
["spawnDroplet", Vector2(1320,1080), "up"],
],
beatToNote(3,33): [
["spawnDroplet", Vector2(840,0), "down"],
["spawnDroplet", Vector2(1080,1080), "up"],
],
beatToNote(1,34): [
["spawnDroplet", Vector2(1920,65), "left"],
["spawnDroplet", Vector2(0,1025), "right"],
],
beatToNote(3,34): [
["spawnDroplet", Vector2(1920,185), "left"],
["spawnDroplet", Vector2(0,905), "right"],
],
beatToNote(1,35): [
["spawnDroplet", Vector2(1920,305), "left"],
["spawnDroplet", Vector2(0,785), "right"],
],
beatToNote(3,35): [
["spawnDroplet", Vector2(1920,425), "left"],
["spawnDroplet", Vector2(0,665), "right"],
],
beatToNote(1,36): [
["spawnDroplet", Vector2(1920,665), "left"],
["spawnDroplet", Vector2(0,665), "right"],
],
beatToNote(3,36): [
["spawnDroplet", Vector2(100,0), "down"],
["spawnDroplet", Vector2(1800,1080), "up"],
],
beatToNote(1,37): [
["spawnDroplet", Vector2(360,0), "down"],
["spawnDroplet", Vector2(1560,1080), "up"],
],
beatToNote(3,37): [
["spawnDroplet", Vector2(600,0), "down"],
["spawnDroplet", Vector2(1320,1080), "up"],
],
beatToNote(1,38): [
["spawnDroplet", Vector2(840,0), "down"],
["spawnDroplet", Vector2(1080,1080), "up"],
],
beatToNote(3,38): [
["spawnDroplet", Vector2(1920,65), "left"],
["spawnDroplet", Vector2(0,1025), "right"],
],
beatToNote(1,39): [
["spawnDroplet", Vector2(1920,185), "left"],
["spawnDroplet", Vector2(0,905), "right"],
],
beatToNote(3,39): [
["spawnDroplet", Vector2(1920,305), "left"],
["spawnDroplet", Vector2(0,785), "right"],
],
beatToNote(1,40): [
["spawnDroplet", Vector2(1920,425), "left"],
["spawnDroplet", Vector2(0,665), "right"],
],
beatToNote(3,40): [
["spawnDroplet", Vector2(1920,665), "left"],
["spawnDroplet", Vector2(0,665), "right"],
],
beatToNote(1,41): [
["spawnDroplet", Vector2(100,0), "down"],
["spawnDroplet", Vector2(1800,1080), "up"],
],
beatToNote(3,41): [
["spawnDroplet", Vector2(360,0), "down"],
["spawnDroplet", Vector2(1560,1080), "up"],
],
beatToNote(1,42): [
["spawnDroplet", Vector2(600,0), "down"],
["spawnDroplet", Vector2(1320,1080), "up"],
],
beatToNote(3,42): [
["spawnDroplet", Vector2(840,0), "down"],
["spawnDroplet", Vector2(1080,1080), "up"],
],
beatToNote(1,43): [
["spawnDroplet", Vector2(1920,65), "left"],
["spawnDroplet", Vector2(0,1025), "right"],
],
beatToNote(3,43): [
["spawnDroplet", Vector2(1920,185), "left"],
["spawnDroplet", Vector2(0,905), "right"],
],
beatToNote(1,44): [
["spawnDroplet", Vector2(1920,305), "left"],
["spawnDroplet", Vector2(0,785), "right"],
],
beatToNote(3,44): [
["spawnDroplet", Vector2(1920,425), "left"],
["spawnDroplet", Vector2(0,665), "right"],
],
beatToNote(1,45): [
["spawnDroplet", Vector2(1920,665), "left"],
["spawnDroplet", Vector2(0,665), "right"],
],beatToNote(3,45): [
["spawnDroplet", Vector2(100,0), "down"],
["spawnDroplet", Vector2(1800,1080), "up"],
],
beatToNote(1,46): [
["spawnDroplet", Vector2(360,0), "down"],
["spawnDroplet", Vector2(1560,1080), "up"],
],
beatToNote(3,46): [
["spawnDroplet", Vector2(600,0), "down"],
["spawnDroplet", Vector2(1320,1080), "up"],
],
beatToNote(1,47): [
["spawnDroplet", Vector2(840,0), "down"],
["spawnDroplet", Vector2(1080,1080), "up"],
],
beatToNote(3,47): [
["spawnDroplet", Vector2(1920,65), "left"],
["spawnDroplet", Vector2(0,1025), "right"],
],

#Circular droplet bombs/spawns
beatToNote(1,52): [
	["circleOfDroplets", Vector2(960,560), "small"]
],
beatToNote(3,52): [
	["circleOfDroplets", Vector2(960,560), "medium"]
],
beatToNote(1,53): [
	["circleOfDroplets", Vector2(960,560), "large"]
],
beatToNote(3,53): [
	["circleOfDroplets", Vector2(960,560), "small"]
],
beatToNote(1,54): [
	["circleOfDroplets", Vector2(960,560), "medium"]
],
beatToNote(3,54): [
	["circleOfDroplets", Vector2(960,560), "large"]
],
beatToNote(1,55): [
	["circleOfDroplets", Vector2(960,560), "small"]
],
beatToNote(3,55): [
	["circleOfDroplets", Vector2(960,560), "medium"]
],
beatToNote(1,56): [
	["circleOfDroplets", Vector2(960,560), "large"]
],
beatToNote(3,56): [
	["circleOfDroplets", Vector2(960,560), "small"]
],
beatToNote(1,57): [
	["circleOfDroplets", Vector2(960,560), "medium"]
],
beatToNote(3,57): [
	["circleOfDroplets", Vector2(960,560), "large"]
],
beatToNote(1,58): [
	["circleOfDroplets", Vector2(960,560), "small"]
],
beatToNote(3,58): [
	["circleOfDroplets", Vector2(960,560), "medium"]
],
beatToNote(1,59): [
	["circleOfDroplets", Vector2(960,560), "large"]
],
beatToNote(3,59): [
	["circleOfDroplets", Vector2(960,560), "small"]
],
beatToNote(1,60): [
	["circleOfDroplets", Vector2(960,560), "medium"]
],
beatToNote(3,60): [
	["circleOfDroplets", Vector2(960,560), "large"]
],
beatToNote(1,61): [
	["circleOfDroplets", Vector2(960,560), "small"]
],
beatToNote(3,61): [
	["circleOfDroplets", Vector2(960,560), "medium"]
],
beatToNote(1,62): [
	["circleOfDroplets", Vector2(960,560), "large"]
],
beatToNote(3,62): [
	["circleOfDroplets", Vector2(960,560), "small"]
],
beatToNote(1,63): [
	["circleOfDroplets", Vector2(960,560), "medium"]
],
beatToNote(3,63): [
	["circleOfDroplets", Vector2(960,560), "large"]
],
}

var duck_teleport_schedule = {}

#Quacks at start of song
var initialQuacks = [117,118,120,122,123,124,126,133,134,136,138,139,140,142,
149,150,152,154,155,156,158,160,162,164,166,168,169,170,171,172,174,175, 181,
182,184,186,187,188,190,197,198,200,202,203,204,206,213,214,216,218,219,220,
222,224,226,227,228,230,232,233,234,235,236,237,238]


#Physics proccess
func _process(delta):
	if (spinning):
		angle += angular_speed * delta
		var offset = Vector2(cos(angle) * radius_x, sin(angle) * radius_y)
		global_position = center_position + offset

		# Calculate angle to center
		var direction = (center_position - global_position).angle()
		rotation = direction + deg_to_rad(angle_offset)

#Shoot a water beam from the duck's mouth with telegraphing
func shootBeam(pos, dir):
	var beam_instance = waterbeam.instantiate()
	beam_instance.direction = dir
	beam_instance.global_position = pos
	beam_instance.telegraph_time = sec_per_measure
	beam_instance.active_time = sec_per_measure
	get_tree().current_scene.add_child(beam_instance)

#Shoot a water stream for the drop section
func shootDropBeam(pos, dir):
	var beam_instance = waterbeam.instantiate()
	beam_instance.direction = dir
	beam_instance.telegraph_time = 0
	beam_instance.active_time = sec_per_measure * 16 - 1.5
	beam_instance.global_scale = Vector2(4,2)
	beam_instance.show_behind_parent = true
	spawn.add_child(beam_instance) # Add to the duck's StreamSpawn node
	beam_instance.position = Vector2.ZERO # Spawn at the mouth position

#Shoot a droplet from the duck's mouth with telegraphing
func shootDroplet(pos, vel):
	var droplet_instance = droplet.instantiate()
	droplet_instance.global_position = pos
	droplet_instance.global_rotation = 90
	droplet_instance.telegraph_time = sec_per_measure
	droplet_instance.velocity = vel
	get_tree().current_scene.add_child(droplet_instance)

#Drop a water droplet from the ceiling with telegraphing
func spawnDroplet(pos, dir):
	var droplet_instance = droplet.instantiate()
	droplet_instance.global_position = pos
	droplet_instance.telegraph_time = sec_per_measure
	droplet_instance.input_dir = dir
	get_tree().current_scene.add_child(droplet_instance)

var angle_offset_circle := 0.0  # In radians
var angle_increment := deg_to_rad(45)  # Rotate the circle by 15 degrees each time

func circleOfDroplets(pos: Vector2, size: String):
	print("Offset angle (deg): ", rad_to_deg(angle_offset_circle))

	var droplet_count := 0
	var radius := 0.0
	
	match size:
		"small":
			droplet_count = 6
			radius = 60
		"medium":
			droplet_count = 10
			radius = 100
		"large":
			droplet_count = 16
			radius = 140

	for i in range(droplet_count):
		var angle = (TAU / droplet_count) * i + angle_offset_circle
		var offset = Vector2(cos(angle), sin(angle)) * radius
		var spawn_pos = pos + offset
		var velocity = offset.normalized()
		
		shootDroplet(spawn_pos, velocity)

	# Increment and wrap the offset
	angle_offset_circle = fmod(angle_offset_circle + angle_increment, TAU)

#Flip the sprite the other way
func lookRight():
	self.scale.x = initial_scale.x * -1

func lookLeft():
	self.rotation_degrees = 0
	self.scale = initial_scale

func lookUp():
	self.rotation_degrees = 90

func lookDown():
	self.rotation_degrees = -90

#Move straight sideways to a x pos
func moveSideways(xCoord, duration):
	var tween = create_tween()
	tween.tween_property(self, "position:x", xCoord, duration)

#Move straigh up to a y pos
func moveVertically(yCoord, duration):
	var tween = create_tween()
	tween.tween_property(self, "position:y", yCoord, duration)

#Fade out and in to a new x y location and facing a direction
func teleport(xCoord, yCoord, lookingWhere):
	var fade_out = create_tween()
	fade_out.tween_property(self, "modulate:a", 0.0, 0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	await fade_out.finished

	# Move and flip
	position = Vector2(xCoord, yCoord)
	if lookingWhere == "left":
		lookLeft()
	elif lookingWhere == "right":
		lookRight()
	elif lookingWhere == "up":
		lookUp()
	elif lookingWhere == "down":
		lookDown()

	var fade_in = create_tween()
	fade_in.tween_property(self, "modulate:a", 1.0, 0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	await fade_in.finished

#Scaling up at the intro
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

#Scaling down at the intro
func settleToNormal():
	var tween = create_tween()
	tween.set_parallel(true)
	
	#Become smaller
	tween.tween_property(self, "scale:x", 0.3, 3.5)
	tween.tween_property(self, "scale:y", 0.3, 3.5)
	
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)

#Updates on the measure signal that don't need telegraphing
var teleported = false #For the drop teleport before spinning
func duckMeasureUpdate(measure):
	current_measure = measure;
	
	#Laughs
	if (current_measure == 18):
		play("Laugh")
		moveSideways(230,sec_per_measure)
	
	if (current_measure == 22):
		play("Laugh")
		moveSideways(1700,sec_per_measure)
	
	#Drop
	if (current_measure == 32):
		play("Enraged")
		spinning = true
		if (!teleported): teleport(1000,540,"left")
		teleported = true;
		shootDropBeam(Vector2(0,0),"left")
	
	#First half of drop (spinning) end
	if (current_measure == 48):
		play("Idle")
		spinning = false
	
	#Circle emitting bumps on 2nd half
	if (current_measure >= 52 and current_measure < 63):
		#circle droplet spawning bumps
		pass

#Updates on the beat signal that don't need telegraphing
func duckBeatUpdate(beat):
	current_beat = beat;
	
	#Buildup
	if (current_measure >= 24 and current_measure <= 29):
		play("QuackSlower")
	
	#Drop bass hits
	if (current_measure >= 32 and current_measure < 48):
		if (beat == 1 or beat == 3):
			#second beat bass hit stuff
			pass

#Updates on the note signal (mostly no telegraphing except the obstacle schedule)
func duckNoteUpdate(note):
	current_note = note;
	
	var future_note = note + total_notes_per_measure
	
	#Perform the obstacle library actions
	if obstacle_schedule.has(future_note):
		var actions = obstacle_schedule[future_note]
		for action_data in actions:
			var action = action_data[0]
			var position = action_data[1]
			var direction = action_data[2]
			match action:
				"shootBeam":
					shootBeam(position, direction)
					duck_teleport_schedule[future_note] = [position, direction]
				"spawnDroplet":
					spawnDroplet(position, direction)
				"circleOfDroplets":
					circleOfDroplets(position, direction)

	
	#Handle teleports
	if duck_teleport_schedule.has(current_note):
		var teleport_data = duck_teleport_schedule[current_note]
		var target_pos = teleport_data[0]
		var look_dir = teleport_data[1]
		teleport(target_pos.x, target_pos.y, look_dir)
		duck_teleport_schedule.erase(current_note)  # Prevent repeat
	
	#Move down
	if (note == 48):
		moveVertically(900,sec_per_measure*4)
	
	#Initial quacks
	if (initialQuacks.has(current_note)):
		play("Quack")
	
	#Flip left side and move up
	if (note == 292):
		lookRight()
		moveVertically(190,sec_per_measure*4)
	
	#Flip right side
	if (note == 360):
		lookLeft()
	
	#Drop quack
	if (current_note == 493):
		play("DropQuack")
	
	#Teleport after spinning
	if (current_note == measureToNote(48)):
		teleport(960,560,"left")

#Getting the note that a beat happens at
func beatToNote(beat, measure) -> int:
	return ((measure - 1) * beats_per_measure + (beat - 1)) * notes_per_beat

#Getting the note that a measure happens at
func measureToNote(measure) -> int:
	return (measure - 1) * total_notes_per_measure

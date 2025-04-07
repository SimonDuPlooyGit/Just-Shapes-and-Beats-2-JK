extends Node

class Note:
	var obstacle_type: String
	var positionV: String
	var side: String
	var positionH: int
	
	func _init(type: String, V: String, S: String, H: int):
		self.obstacle_type = type
		self.positionV = V
		self.side = S
		self.positionH = H

var horizontal_positions = {
	1: Vector2(0,36),
	2: Vector2(0,108),
	3: Vector2(0,180),
	4: Vector2(0,252),
	5: Vector2(0,324),
	6: Vector2(0,396),
	7: Vector2(0,468),
	8: Vector2(0,540),
	9: Vector2(0,612),
	10: Vector2(0,684),
	11: Vector2(0,756),
	12: Vector2(0,828),
	13: Vector2(0,900),
	14: Vector2(0,972),
	15: Vector2(0,1044),
}

var vertical_positions = {
	"A": Vector2(96,540),
	"B": Vector2(288,540),
	"C": Vector2(480,540),
	"D": Vector2(672,540),
	"E": Vector2(864,540),
	"F": Vector2(1056,540),
	"G": Vector2(1248,540),
	"H": Vector2(1440,540),
	"I": Vector2(1632,540),
	"J": Vector2(1824,540),
}

var quadrant_positions = {
	1: Vector2(1440,280),
	2: Vector2(480,280),
	3: Vector2(480,840),
	4: Vector2(1440,840),
}

var wave_arrays = {
	"top":[Note.new("bullet", "A", "top", 0),Note.new("bullet", "B", "top", 0),Note.new("bullet", "C", "top", 0),Note.new("bullet", "D", "top", 0),
	Note.new("bullet", "E", "top", 0),Note.new("bullet", "F", "top", 0),Note.new("bullet", "G", "top", 0),Note.new("bullet", "H", "top", 0),
	Note.new("bullet", "I", "top", 0),Note.new("bullet", "J", "top", 0),],
	
	"bottom":[Note.new("bullet", "A", "bottom", 0),Note.new("bullet", "B", "bottom", 0),Note.new("bullet", "C", "bottom", 0),Note.new("bullet", "D", "bottom", 0),
	Note.new("bullet", "E", "bottom", 0),Note.new("bullet", "F", "bottom", 0),Note.new("bullet", "G", "bottom", 0),Note.new("bullet", "H", "bottom", 0),
	Note.new("bullet", "I", "bottom", 0),Note.new("bullet", "J", "bottom", 0),],
	
	"right":[Note.new("bullet", ".", "right", 1),Note.new("bullet", ".", "right", 2),Note.new("bullet", ".", "right", 3),Note.new("bullet", ".", "right", 4),Note.new("bullet", ".", "right", 5),
	Note.new("bullet", ".", "right", 6),Note.new("bullet", ".", "right", 7),Note.new("bullet", ".", "right", 8),Note.new("bullet", ".", "right", 9),Note.new("bullet", ".", "right", 10),
	Note.new("bullet", ".", "right", 11),Note.new("bullet", ".", "right", 12),Note.new("bullet", ".", "right", 13),Note.new("bullet", ".", "right", 14),Note.new("bullet", ".", "right", 15)],
	
	"left":[Note.new("bullet", ".", "left", 1),Note.new("bullet", ".", "left", 2),Note.new("bullet", ".", "left", 3),Note.new("bullet", ".", "left", 4),Note.new("bullet", ".", "left", 5),
	Note.new("bullet", ".", "left", 6),Note.new("bullet", ".", "left", 7),Note.new("bullet", ".", "left", 8),Note.new("bullet", ".", "left", 9),Note.new("bullet", ".", "left", 10),
	Note.new("bullet", ".", "left", 11),Note.new("bullet", ".", "left", 12),Note.new("bullet", ".", "left", 13),Note.new("bullet", ".", "left", 14),Note.new("bullet", ".", "left", 15)],
}

var note_library = {
	17: [Note.new("beam", ".", "right", 1)],
	18: [Note.new("beam", ".", "right", 2)],
	19: [Note.new("beam", ".", "right" ,3)],
	20: [Note.new("beam", ".", "right", 4)],
	21: [Note.new("beam", ".", "right", 5)],
	22: [Note.new("beam", ".", "right", 6)],
	23: [Note.new("beam", ".", "right", 7)],
	24: wave_arrays.get("right"),
	
	33: [Note.new("beam", ".", "right", 15)],
	34: [Note.new("beam", ".", "right", 14)],
	35: [Note.new("beam", ".", "right", 13)],
	36: [Note.new("beam", ".", "right", 12)],
	37: [Note.new("beam", ".", "right", 11)],
	38: [Note.new("beam", ".", "right", 10)],
	39: [Note.new("beam", ".", "right", 9)],
	40: wave_arrays.get("left"),
	
	49: [Note.new("beam", "A", "top", 0)],
	50: [Note.new("beam", "J", "top", 0)],
	51: [Note.new("beam", "C", "top", 0)],
	52: [Note.new("beam", "H", "top", 0)],
	53: [Note.new("beam", "E", "top", 0)],
	54: [Note.new("beam", "F", "top", 0)],
	#55: [Note.new("beam", "A", "top", 0)],
	56: [Note.new("beam", ".", "diagonal", 0)],
	
	73: [Note.new("bullet", ".", "right", 1)],
	74: [Note.new("bullet", ".", "right", 2)],
	75: [Note.new("bullet", ".", "right", 3)],
	76: [Note.new("bullet", ".", "right", 4)],
	77: [Note.new("bullet", ".", "right", 5)],
	78: [Note.new("bullet", ".", "right", 6)],
	79: [Note.new("bullet", ".", "right", 7)],
	
	81: [Note.new("bullet", ".", "right", 9)],
	82: [Note.new("bullet", ".", "right", 10)],
	83: [Note.new("bullet", ".", "right", 11)],
	
	85: [Note.new("bullet", ".", "right", 13)],
	86: [Note.new("bullet", ".", "right", 14)],
	87: [Note.new("bullet", ".", "right", 15)],
	
	89: [Note.new("bullet", ".", "left", 15)],
	90: [Note.new("bullet", ".", "left", 14)],
	91: [Note.new("bullet", ".", "left", 13)],
	92: [Note.new("bullet", ".", "left", 12)],
	93: [Note.new("bullet", ".", "left", 11)],
	94: [Note.new("bullet", ".", "left", 10)],
	95: [Note.new("bullet", ".", "left", 9)],
	
	97: [Note.new("bullet", ".", "left", 7)],
	98: [Note.new("bullet", ".", "left", 6)],
	99: [Note.new("bullet", ".", "left", 5)],
	
	101: [Note.new("bullet", ".", "left", 3)],
	102: [Note.new("bullet", ".", "left", 2)],
	103: [Note.new("bullet", ".", "left", 1)],
	
	104: [Note.new("bullet", "A", "top", 0), Note.new("bullet", "J", "bottom", 0)],
	105: [Note.new("bullet", "B", "top", 0), Note.new("bullet", "I", "bottom", 0)],
	106: [Note.new("bullet", "C", "top", 0), Note.new("bullet", "H", "bottom", 0)],
	107: [Note.new("bullet", "D", "top", 0), Note.new("bullet", "G", "bottom", 0)],
	108: [Note.new("bullet", "E", "top", 0), Note.new("bullet", "F", "bottom", 0)],
	109: [Note.new("bullet", "F", "top", 0), Note.new("bullet", "E", "bottom", 0)],
	110: [Note.new("bullet", "G", "top", 0), Note.new("bullet", "D", "bottom", 0)],
	
	112: [Note.new("bullet", ".", "left", 9),Note.new("bullet", ".", "right", 7)],
	113: [Note.new("bullet", ".", "left", 8),Note.new("bullet", ".", "right", 8)],
	114: [Note.new("bullet", ".", "left", 7),Note.new("bullet", ".", "right", 9)],
	
	116: [Note.new("bullet", ".", "left", 7),Note.new("bullet", ".", "right", 9)],
	117: [Note.new("bullet", ".", "left", 6),Note.new("bullet", ".", "right", 10)],
	118: [Note.new("bullet", ".", "left", 5),Note.new("bullet", ".", "right", 11)],
	
	120: [Note.new("bullet", "D", "top", 0),Note.new("bullet", "E", "top", 0),Note.new("bullet", "F", "top", 0),
	Note.new("bullet", "G", "top", 0), Note.new("bullet", "H", "top", 0),Note.new("bullet", "I", "top", 0),Note.new("bullet", "A", "bottom", 0),
	Note.new("bullet", "B", "Bottom", 0),Note.new("bullet", "C", "bottom", 0),Note.new("bullet", "D", "Bottom", 0),Note.new("bullet", "E", "Bottom", 0),
	Note.new("bullet", "F", "bottom", 0),Note.new("bullet", "G", "bottom", 0),Note.new("bullet", "H", "Bottom", 0)],
	121:[Note.new("bullet", "D", "top", 0),Note.new("bullet", "E", "top", 0),Note.new("bullet", "F", "top", 0),
	Note.new("bullet", "G", "top", 0), Note.new("bullet", "H", "top", 0),Note.new("bullet", "I", "top", 0),Note.new("bullet", "A", "bottom", 0),
	Note.new("bullet", "B", "Bottom", 0),Note.new("bullet", "C", "bottom", 0),Note.new("bullet", "D", "Bottom", 0),Note.new("bullet", "E", "Bottom", 0),
	Note.new("bullet", "F", "bottom", 0),Note.new("bullet", "G", "bottom", 0),Note.new("bullet", "H", "Bottom", 0)],
	122:[Note.new("bullet", "D", "top", 0),Note.new("bullet", "E", "top", 0),Note.new("bullet", "F", "top", 0),
	Note.new("bullet", "G", "top", 0), Note.new("bullet", "H", "top", 0),Note.new("bullet", "I", "top", 0),Note.new("bullet", "A", "bottom", 0),
	Note.new("bullet", "B", "Bottom", 0),Note.new("bullet", "C", "bottom", 0),Note.new("bullet", "D", "Bottom", 0),Note.new("bullet", "E", "Bottom", 0),
	Note.new("bullet", "F", "bottom", 0),Note.new("bullet", "G", "bottom", 0),Note.new("bullet", "H", "Bottom", 0)],
	
	123: [Note.new("bullet", ".", "left", 1),Note.new("bullet", ".", "left", 2),Note.new("bullet", ".", "left", 3),
	Note.new("bullet", ".", "left", 4),Note.new("bullet", ".", "left", 5),Note.new("bullet", ".", "left", 6),Note.new("bullet", ".", "left", 7),
	Note.new("bullet", ".", "right", 15),Note.new("bullet", ".", "right", 14),Note.new("bullet", ".", "right", 13),
	Note.new("bullet", ".", "right", 12),Note.new("bullet", ".", "right", 11),Note.new("bullet", ".", "right", 10),Note.new("bullet", ".", "right", 9),],
	124:[Note.new("bullet", ".", "left", 1),Note.new("bullet", ".", "left", 2),Note.new("bullet", ".", "left", 3),
	Note.new("bullet", ".", "left", 4),Note.new("bullet", ".", "left", 5),Note.new("bullet", ".", "left", 6),Note.new("bullet", ".", "left", 7),
	Note.new("bullet", ".", "right", 15),Note.new("bullet", ".", "right", 14),Note.new("bullet", ".", "right", 13),
	Note.new("bullet", ".", "right", 12),Note.new("bullet", ".", "right", 11),Note.new("bullet", ".", "right", 10),Note.new("bullet", ".", "right", 9),],
	125:[Note.new("bullet", ".", "left", 1),Note.new("bullet", ".", "left", 2),Note.new("bullet", ".", "left", 3),
	Note.new("bullet", ".", "left", 4),Note.new("bullet", ".", "left", 5),Note.new("bullet", ".", "left", 6),Note.new("bullet", ".", "left", 7),
	Note.new("bullet", ".", "right", 15),Note.new("bullet", ".", "right", 14),Note.new("bullet", ".", "right", 13),
	Note.new("bullet", ".", "right", 12),Note.new("bullet", ".", "right", 11),Note.new("bullet", ".", "right", 10),Note.new("bullet", ".", "right", 9),],
	
	126: [Note.new("beam", ".", "right", 8)],
	
	136: [Note.new("area", ".", "one", 4),Note.new("area", ".", "one", 1)],
	138: [Note.new("area", ".", "two", 2)],
	144: [Note.new("area", ".", "two", 1),Note.new("area", ".", "one", 2)],
	146: [Note.new("area", ".", "two", 3)],
	152: [Note.new("area", ".", "two", 2),Note.new("area", ".", "one", 3)],
	154: [Note.new("area", ".", "two", 4)],
	
	168: [Note.new("area", ".", "two", 4),Note.new("area", ".", "one", 3)],
	170: [Note.new("area", ".", "two", 2)],
	176: [Note.new("area", ".", "two", 2),Note.new("area", ".", "one", 3)],
	178: [Note.new("area", ".", "two", 1)],
	184: [Note.new("area", ".", "two", 2),Note.new("area", ".", "one", 1)],
	186: [Note.new("area", ".", "two", 4)],
	
	200: wave_arrays.get("right"),
	204: wave_arrays.get("bottom"),
	208: wave_arrays.get("left"),
	212: wave_arrays.get("top"),
	
	216: wave_arrays.get("right"),
	220: wave_arrays.get("bottom"),
	224: wave_arrays.get("left") + [Note.new("beam", "J", "top", 0)],
	225: [Note.new("beam", "I", "top", 0)],
	226: [Note.new("beam", "H", "top", 0)],
	227: [Note.new("beam", "G", "top", 0)],
	228: wave_arrays.get("top") + [Note.new("beam", "F", "top", 0)],
	229: [Note.new("beam", "E", "top", 0)],
	230: [Note.new("beam", "D", "top", 0)],
	231: [Note.new("beam", "C", "top", 0)],
	
	232: wave_arrays.get("right"),
	236: wave_arrays.get("bottom"),
	240: wave_arrays.get("left"),
	244: wave_arrays.get("top"),
	
	248: wave_arrays.get("right"),
	252: wave_arrays.get("bottom"),
	256: wave_arrays.get("left") + [Note.new("beam", "A", "top", 0)],
	257: [Note.new("beam", "B", "top", 0)],
	258: [Note.new("beam", "C", "top", 0)],
	259: [Note.new("beam", "D", "top", 0)],
	260: [Note.new("beam", "E", "top", 0)],
	261: [Note.new("beam", "F", "top", 0)],
	
	264: wave_arrays.get("right"),
	268: wave_arrays.get("bottom"),
	272: wave_arrays.get("left"),
	276: wave_arrays.get("top"),
	
	280: wave_arrays.get("right"),
	284: wave_arrays.get("bottom"),
	288: wave_arrays.get("left") + [Note.new("beam", "J", "top", 0)],
	289: [Note.new("beam", "I", "top", 0)],
	290: [Note.new("beam", "H", "top", 0)],
	291: [Note.new("beam", "G", "top", 0)],
	292: wave_arrays.get("top") + [Note.new("beam", "F", "top", 0)],
	293: [Note.new("beam", "E", "top", 0)],
	294: [Note.new("beam", "D", "top", 0)],
	
	296: wave_arrays.get("right"),
	300: wave_arrays.get("bottom"),
	304: wave_arrays.get("left"),
	308: wave_arrays.get("top"),
	
	312: wave_arrays.get("right"),
	316: wave_arrays.get("bottom"),
}

func spawn_obstacle(note):
	var note_data_list = note_library.get(note + 8)

	if note_data_list == null:
		#print("Note is empty")
		return
	
	for note_data in note_data_list:
		match note_data.obstacle_type:
			"beam":
				spawn_beam(note_data.side, note_data.positionH, note_data.positionV)
			"bullet":
				spawn_bullet(note_data.side, note_data.positionH, note_data.positionV)
			"area":
				spawn_area(note_data.positionH)
			_:
				pass  # Handle other obstacle types if needed

var beam = preload("res://Obstacles/Beam.tscn")
var wave = preload("res://Obstacles/Wave.tscn")
var vbeam = preload("res://Obstacles/vbeam.tscn")
var dbeam = preload("res://Obstacles/dbeam.tscn")
var bullet = preload("res://Obstacles/Bullet.tscn")
var barea = preload("res://Obstacles/BadArea.tscn")

func spawn_beam(side, positionH, positionV):
	if (side == "right"):
		var b = beam.instantiate()
		add_child(b)
		b.position = horizontal_positions.get(positionH)
	elif (side == "top"):
		var b = vbeam.instantiate()
		add_child(b)
		b.position = vertical_positions.get(positionV)
	elif (side == "diagonal"):
		var b = dbeam.instantiate()
		add_child(b)
		var b2 = dbeam.instantiate()
		add_child(b2)
		b2.rotation_degrees = 45
		var b3 = dbeam.instantiate()
		add_child(b3)
		b3.rotation_degrees = 90
		var b4 = dbeam.instantiate()
		add_child(b4)
		b4.rotation_degrees = 135
		
	else:
		pass

func spawn_bullet(side, positionH, positionV):
	var bul = bullet.instantiate()
	add_child(bul)
	if (side == "right"):
		bul.position = horizontal_positions.get(positionH)
		bul.position += Vector2(1920,0)
		bul.setup(Vector2(0,bul.position.y)-bul.position)
	elif (side == "left"):
		bul.position = horizontal_positions.get(positionH)
		bul.setup(Vector2(1920,bul.position.y)-bul.position)
	elif (side == "top"):
		bul.position = vertical_positions.get(positionV)
		bul.position -= Vector2(0,560)
		bul.setup(Vector2(bul.position.x, 1080)-bul.position)
	else:
		bul.position = vertical_positions.get(positionV)
		bul.position += Vector2(0,560)
		bul.setup(Vector2(bul.position.x, 0)-bul.position)
	pass

func spawn_area(positionH):
	#print("Area should spawn!")
	var ba = barea.instantiate()
	add_child(ba)
	if(positionH == 1):
		ba.position = quadrant_positions.get(positionH)
	if(positionH == 2):
		ba.position = quadrant_positions.get(positionH)
	if(positionH == 3):
		ba.position = quadrant_positions.get(positionH)
	if(positionH == 4):
		ba.position = quadrant_positions.get(positionH)

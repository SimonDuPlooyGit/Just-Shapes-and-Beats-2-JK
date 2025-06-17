extends Area2D

@onready var sprite := $Sprite2D
@onready var collision_shape := $CollisionShape2D

var telegraph_time := 0.0 # Time in seconds before it becomes active
var input_dir = ""
var direction = 0
@export var speed = 600
var velocity := Vector2.ZERO
var overlap_body
var has_damaged_player := false

@onready var telegraph_timer := Timer.new()
var is_active := false

func _ready() -> void:
	telegraph_timer.wait_time = telegraph_time
	telegraph_timer.one_shot = true
	telegraph_timer.autostart = false
	telegraph_timer.process_mode = Node.PROCESS_MODE_PAUSABLE
	add_child(telegraph_timer)
	
	# Initial state: invisible and harmless
	modulate.a = 0.3
	collision_shape.disabled = true
	telegraph_timer.start()

	# Wait for telegraph period
	await telegraph_timer.timeout

	# Activate: full opacity and enable collision
	modulate.a = 1.0
	collision_shape.disabled = false
	is_active = true
	
	#Rotate if shootdroplet was used
	if velocity != Vector2.ZERO:
		rotation = velocity.angle() - deg_to_rad(90)
	
	if (input_dir == "down"):
		direction = 1
	elif (input_dir == "up"):
		direction = -1
		self.global_rotation = deg_to_rad(180)
	elif (input_dir == "left"):
		direction = -1
		self.global_rotation = deg_to_rad(90)
	elif (input_dir == "right"):
		direction = 1
		self.global_rotation = deg_to_rad(-90)

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
	
	#Move in the velocity direction if shoot was used
	if velocity != Vector2.ZERO and is_active: position += velocity.normalized() * speed * delta
	
	if (input_dir == "down" or input_dir == "up"):
		position.y += speed * direction * delta
	elif (input_dir == "left" or input_dir == "right"):
		position.x += speed * direction * delta
	
	if (self.position.x > 1920 || self.position.x < 0):
		queue_free()
	elif (self.position.y > 1080 || self.position.y < 0):
		queue_free()

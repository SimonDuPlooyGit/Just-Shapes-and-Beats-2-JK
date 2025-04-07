extends CharacterBody2D

@export var speed = 400
@export var dash_speed = 800
@export var dash_duration = 0.3  # Duration of the dash in seconds
@onready var collision_shape = $CollisionShape2D # Assuming the CollisionShape2D node is directly a child of the player
@export var lives = 3
@export var invince_time = 1

var is_dashing = false
var dash_timer = 0.0
var taking_damage = false
var damage_timer = 0

signal life_lost(necessary)

func get_input() -> Vector2:
	var input_vector = Vector2(
		Input.get_action_raw_strength("Right") - Input.get_action_raw_strength("Left"),
		Input.get_action_raw_strength("Down") - Input.get_action_raw_strength("Up")
	)
	return input_vector.normalized()

func _physics_process(delta):
	var screen_rect = get_viewport_rect()
	position.x = clamp(position.x, 0, screen_rect.size.x)
	position.y = clamp(position.y, 0, screen_rect.size.y)
	
	if damage_timer > 0:
		damage_timer -= delta
		set_sprite_opacity(0.5)
	elif not is_dashing:
		set_sprite_opacity(1)
	# Handle dash
	if Input.is_action_just_pressed("Dash") and not is_dashing:
		start_dash()
	
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			end_dash()
	
	var input_direction = get_input()
	# Use dash speed if dashing, else normal speed
	var current_speed = speed
	if is_dashing:
		current_speed = dash_speed
	
	velocity = input_direction * current_speed
	move_and_slide()

	# Handle collisions (optional: implement logic on how to handle collisions during dash)
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if damage_timer <=0:
			lose_life()
			

func start_dash():
	# Disable collision
	collision_shape.disabled = true
	is_dashing = true
	dash_timer = dash_duration
	set_sprite_opacity(0.5)

func end_dash():
	# Re-enable collision
	collision_shape.disabled = false
	is_dashing = false
	if damage_timer <= 0:
		set_sprite_opacity(1)

func lose_life():
	if damage_timer <= 0:
		lives -= 1
		emit_signal("life_lost",22)
		damage_timer = invince_time
	if (lives == 2):
		$Sprite2D.modulate = Color("#FFFF00")
	if (lives == 1):
		$Sprite2D.modulate = Color("#FF0000")
	elif (lives <= 0):
		queue_free()

func set_sprite_opacity(alpha: float):
	var current_color = $Sprite2D.modulate
	current_color.a = alpha
	$Sprite2D.modulate = current_color

extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var camera_pan_speed : float = 0.002

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	# ESC-Taste zum Freigeben/Einfangen der Maus
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	move_and_slide()
	
	
func _input(event):
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			# Spieler um die Y-Achse drehen (Links / Rechts)
			rotation.y -= event.relative.x * camera_pan_speed
			
			# Kamera um die X-Achse neigen (Hoch / Runter) und limitieren
			var target_rot_x = $CameraPivot.rotation.x - event.relative.y * camera_pan_speed
			$CameraPivot.rotation.x = clampf(target_rot_x, -0.8 * PI/2, 0.8 * PI/2)

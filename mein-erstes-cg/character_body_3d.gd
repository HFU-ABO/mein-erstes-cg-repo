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
	
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
	# Handle Mouse speed to rotate player and tilt camera (using the CameraPivot setup)
		var mouse_vel = Input.get_last_mouse_velocity()
		var new_rot_y = rotation.y - mouse_vel.x * delta * camera_pan_speed
		var new_rot_x = clampf($CameraPivot.rotation.x + mouse_vel.y * delta * camera_pan_speed, -0.27 * PI/2, 0.8 * PI/2)
		rotation.y = new_rot_y
		$CameraPivot.rotation.x = new_rot_x

		if Input.is_action_just_pressed("ui_cancel"):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		if Input.is_action_just_pressed("ui_cancel"):
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
	move_and_slide()

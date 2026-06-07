extends Node3D

@export var arm_speed : float = 180
@export var base_speed : float = 180
@export var max_arm_angle : float = 60
@export var min_arm_angle : float = -60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Hallo, ich bin ready!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# print(delta)
	if Input.is_action_pressed("base_left"):
		$Base.rotation.y += deg_to_rad(base_speed) * delta
	if Input.is_action_pressed("base_right"):
		$Base.rotation.y -= deg_to_rad(base_speed) * delta
	
	if Input.is_action_pressed("upper_arm_up"):
		# print("Hoch")
		# $Base/UpperArm.rotate_x(2 * (3.141592 / 180)) # PI / 180 oder deg_to_rad()
		$Base/UpperArm.rotation.x += deg_to_rad(arm_speed) * delta
	if Input.is_action_pressed("upper_arm_down"):
		# print("Runter")
		$Base/UpperArm.rotation.x -= deg_to_rad(arm_speed) * delta
	$Base/UpperArm.rotation.x = clamp($Base/UpperArm.rotation.x,
	deg_to_rad(min_arm_angle),
	deg_to_rad(max_arm_angle))
	
	if Input.is_action_pressed("lower_arm_up"):
		# print("Hoch")
		# $Base/UpperArm.rotate_x(2 * (3.141592 / 180)) # PI / 180 oder deg_to_rad()
		$Base/UpperArm/LowerArm.rotation.x += deg_to_rad(arm_speed) * delta
	if Input.is_action_pressed("lower_arm_down"):
		# print("Runter")
		$Base/UpperArm/LowerArm.rotation.x -= deg_to_rad(arm_speed) * delta
	$Base/UpperArm/LowerArm.rotation.x = clamp($Base/UpperArm/LowerArm.rotation.x,
	deg_to_rad(min_arm_angle),
	deg_to_rad(max_arm_angle))

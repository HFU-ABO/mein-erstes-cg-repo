extends Node3D

@export var upper_arm_speed : float = 180

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Hallo, ich bin ready!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(delta)
	if Input.is_action_pressed("upper_arm_up"):
		# print("Hoch")
		# $Base/UpperArm.rotate_x(2 * (3.141592 / 180)) # PI / 180 oder deg_to_rad()
		$Base/UpperArm.rotate_x(deg_to_rad(upper_arm_speed) * delta)
	if Input.is_action_pressed("upper_arm_down"):
		# print("Runter")
		$Base/UpperArm.rotate_x(deg_to_rad(-upper_arm_speed) * delta)

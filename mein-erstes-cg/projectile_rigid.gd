extends RigidBody3D


func _ready() -> void:
	print("Ready")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("ui_up"):
		apply_impulse(Vector3(0, 0, 10))
		print("Keep rollin!")

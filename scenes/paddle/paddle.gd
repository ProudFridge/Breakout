extends CharacterBody2D

const SPEED: float = 300.0
const maxTiltAngle: float = deg_to_rad(30)
var tiltAccel: float = 10

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	var direction: float= Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Handle the paddle tilt
	if Input.is_action_pressed("tilt_right"):
		rotation = move_toward(rotation, maxTiltAngle, tiltAccel * delta)
	elif Input.is_action_pressed("tilt_left"):
		rotation = move_toward(rotation, -maxTiltAngle, tiltAccel * delta)
	else:
		rotation = move_toward(rotation, 0, tiltAccel * delta)
	
	position.x = get_global_mouse_position().x
	move_and_slide()
	

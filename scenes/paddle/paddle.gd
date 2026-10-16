extends CharacterBody2D
class_name Paddle

var SPEED: float = 500.0
var oriSpeed: float = SPEED
const maxTiltAngle: float = deg_to_rad(15)
var tiltAccel: float = 2

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	#var direction: float= Input.get_axis("move_left", "move_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
	#
	position.x = get_global_mouse_position().x
	
	# Handle the paddle tilt
	if Input.is_action_pressed("tilt_right"):
		rotation = move_toward(rotation, maxTiltAngle, tiltAccel * delta)
	elif Input.is_action_pressed("tilt_left"):
		rotation = move_toward(rotation, -maxTiltAngle, tiltAccel * delta)
	else:
		rotation = move_toward(rotation, 0, tiltAccel * delta)
	
	move_and_slide()

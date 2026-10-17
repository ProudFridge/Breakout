extends CharacterBody2D
class_name Paddle

var SPEED: float = 300.0
var oriSpeed: float = SPEED
const maxTiltAngle: float = deg_to_rad(15)
var tiltAccel: float = 2

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var mesh_instance: MeshInstance2D = $MeshInstance2D

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
	
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	
	# Bounces the ball whenever there's a collision
	if collision:
		var body: Node = collision.get_collider()
		if body is Ability:
			(body as Ability).use_ability()

func set_size(size: Vector2) -> void:
	collision_shape.shape.size = size
	mesh_instance.scale = size

func get_size() -> Vector2:
	return mesh_instance.scale

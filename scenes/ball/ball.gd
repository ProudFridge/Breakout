extends CharacterBody2D

const SPEED: float = 300.0
var initial_vector: Vector2 = Vector2(0,1)

func _ready() -> void:
	velocity = initial_vector * SPEED

func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	
	# Bounces the ball whenever there's a collision
	if collision:
		velocity = velocity.bounce(collision.get_normal())

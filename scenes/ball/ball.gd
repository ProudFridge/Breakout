extends CharacterBody2D

@export var SPEED: float = 300.0
@export var damage: float = 1
var initial_vector: Vector2 = Vector2(0,1)

func _ready() -> void:
	velocity = initial_vector * SPEED

func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	
	# Bounces the ball whenever there's a collision
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		
		if collision.get_collider() is Block:
			collision.get_collider().take_damage(damage)

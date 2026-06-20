extends CharacterBody2D
class_name Ball

@export var SPEED: float = 300.0
@export var damage: float = 1

@onready var death_particles: GPUParticles2D = $DeathParticles

var initial_vector: Vector2 = Vector2(0,1)
var initial_position: Vector2
signal died()

func _ready() -> void:
	velocity = initial_vector * SPEED
	initial_position = position

func _physics_process(delta: float) -> void:		
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	
	# Bounces the ball whenever there's a collision
	if collision:
		var body: Node = collision.get_collider()
		
		velocity = velocity.bounce(collision.get_normal())
		
		if body.is_in_group("BottomWall"):
			die()
			died.emit()
		else:
			AudioManager.play_sound("bounce")
			
		if body is Block:
			body.take_damage(damage)
			
func delete() -> void:
	queue_free()

# Resets the ball's position
func die() -> void:
	position = initial_position
	velocity = Vector2.ZERO

# "Respawns" the ball
func respawn() -> void:
	visible = true
	velocity = initial_vector * SPEED
	
func freeze() -> void:
	velocity = Vector2.ZERO
	visible = false
	$CollisionShape2D.disabled = true

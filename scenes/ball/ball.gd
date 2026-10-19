extends CharacterBody2D
class_name Ball

@export var SPEED: float = 400.0
@export var damage: float = 1
@export var isPiercing: bool = false

@onready var collision_particles: GPUParticles2D = $CollisionParticles
@onready var particle_timer: Timer = $CollisionParticles/ParticleTimer
@onready var mesh_instance_2d: MeshInstance2D = $MeshInstance2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

const BALL: Resource = preload("uid://dpwwvkfv48suw")

var initial_vector: Vector2 = Vector2(0,1)
var initial_position: Vector2
var ballRadius: float = 7

signal died()

func _ready() -> void:
	set_size(ballRadius)
	velocity = initial_vector * SPEED
	initial_position = position
	
	particle_timer.timeout.connect(_on_particle_timer_timeout)

func _physics_process(delta: float) -> void:		
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	
	# Bounces the ball whenever there's a collision
	if collision:
		var body: Node = collision.get_collider()
		
		if body.is_in_group("BottomWall"):
			if _get_ball_count() <= 1:
				AudioManager.play_sound("death")
				reset_ball()
				died.emit()
			else:
				delete()
		else:
			AudioManager.play_sound("bounce")
			
		if body is Block:
			body.take_damage(damage, self)
			
			collision_particles.position = position
			collision_particles.emitting = true
			particle_timer.start()
			
			if not isPiercing:
				velocity = velocity.bounce(collision.get_normal())
		elif body is Paddle:
			var paddleVelocity: Vector2 = (body as Paddle).velocity
			
			# Make the ball reflect less/more depending on the paddle's velocity
			velocity = velocity.bounce(collision.get_normal().rotated(clamp(paddleVelocity.x, -0.1, 0.1)))
		else:
			velocity = velocity.bounce(collision.get_normal())


func set_size(radius: float) -> void:
	(mesh_instance_2d.mesh as SphereMesh).radius = radius
	(mesh_instance_2d.mesh as SphereMesh).height = 2 * radius
	(collision_shape_2d.shape as CircleShape2D).radius = radius
	$TrailComponent.width = radius
	
func delete() -> void:
	queue_free()

## Counts the amount of Ball nodes in the scene tree
func _get_ball_count() -> int:
	return get_tree().get_nodes_in_group("Ball").size()

## Resets the ball's position and clears the trail
func reset_ball() -> void:
	position = initial_position
	$TrailComponent.clear()
	velocity = Vector2.ZERO

# "Respawns" the ball
func respawn() -> void:
	visible = true
	velocity = initial_vector * SPEED
	
func freeze() -> void:
	velocity = Vector2.ZERO
	visible = false
	$CollisionShape2D.disabled = true
	
func _on_particle_timer_timeout() -> void:
	collision_particles.emitting = false

extends CharacterBody2D

@export var SPEED: float = 300.0
@export var damage: float = 1

@onready var collision_sound: AudioStreamPlayer2D = $CollisionSound
@onready var death_particles: GPUParticles2D = $DeathParticles
@onready var respawn_timer: Timer = $RespawnTimer

var initial_vector: Vector2 = Vector2(0,1)
var initial_position: Vector2

func _ready() -> void:
	velocity = initial_vector * SPEED
	initial_position = position

func _physics_process(delta: float) -> void:		
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	
	# Bounces the ball whenever there's a collision
	if collision:
		var body: Node = collision.get_collider()
		#collision_sound.play()
		
		velocity = velocity.bounce(collision.get_normal())
		
		print(body.name)
		if body.is_in_group("BottomWall"):
			die()
		if body is Block:
			body.take_damage(damage)
			
func delete() -> void:
	queue_free()

# Resets the ball's position
func die() -> void:
	position = initial_position
	velocity = Vector2.ZERO
	respawn_timer.start()

func _on_respawn_timer_timeout() -> void:
	visible = true
	velocity = initial_vector * SPEED

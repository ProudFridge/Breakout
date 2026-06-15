extends CharacterBody2D

@export var SPEED: float = 300.0
@export var damage: float = 1

@onready var collision_sound: AudioStreamPlayer2D = $CollisionSound
@onready var death_particles: GPUParticles2D = $DeathParticles

var initial_vector: Vector2 = Vector2(0,1)

func _ready() -> void:
	velocity = initial_vector * SPEED

func _physics_process(delta: float) -> void:		
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	
	# Bounces the ball whenever there's a collision
	if collision:
		var body: Node = collision.get_collider()
		#collision_sound.play()
		
		velocity = velocity.bounce(collision.get_normal())
		
		print(body.name)
		if body.is_in_group("BottomWall"):
			delete()
		if body is Block:
			body.take_damage(damage)
			
func delete() -> void:
	queue_free()

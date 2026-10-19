extends Node
class_name AbilityManager

@export var blockManager: BlockManager
@export var gameManager: GameManager
@export var paddle: Paddle

const BALL: Resource = preload("uid://dpwwvkfv48suw")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blockManager.block_removed.connect(_on_block_manager_block_removed)


# TODO: maybe replace with a class for each abilityType
func _on_block_manager_block_removed(block: Block, ball: Ball) -> void:
	if block.ability == Ability.AbilityType.CLONE:
		print("CLONE")
		AudioManager.play_sound("clone")
		var ballInstance: Ball = BALL.instantiate()
		ballInstance.position = ball.position - Vector2(10, 10)
		ballInstance.initial_position = gameManager.initialBallPosition
		ballInstance.initial_vector = ball.velocity.normalized().rotated(randf_range(-PI / 6, PI / 6))
		ballInstance.modulate = Color.from_hsv(randf_range(0, 1), 1, 1, 1)
		
		add_child(ballInstance)
	elif block.ability == Ability.AbilityType.GROW:
		print("GROW")
		AudioManager.play_sound("grow")
		# TODO: Make the paddle blink as it grows
		paddle.tween_size(Vector2(paddle.get_size().x * 1.2, paddle.get_size().y))
		get_tree().create_timer(5).timeout.connect(func() -> void: paddle.tween_size(Vector2(paddle.get_size().x / 1.2, paddle.get_size().y)))
	

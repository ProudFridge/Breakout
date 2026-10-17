extends Node
class_name AbilityManager

@export var blockManager: BlockManager
@export var gameManager: GameManager

const BALL: Resource = preload("uid://dpwwvkfv48suw")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blockManager.block_removed.connect(_on_block_manager_block_removed)


func _on_block_manager_block_removed(block: Block, ball: Ball) -> void:
	if block.ability == Ability.AbilityType.CLONE:
		print("CLONE")
		var ballInstance: Ball = BALL.instantiate()
		ballInstance.position = ball.position - Vector2(10, 10)
		ballInstance.initial_vector = ball.velocity.normalized().rotated(randf_range(-PI / 6, PI / 6))
		add_child(ballInstance)
	

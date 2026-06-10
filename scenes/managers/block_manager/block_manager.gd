extends Node
class_name BlockManager

@export var blocksX: int = 5
@export var blocksY: int = 5

@export var paddingX: float = 1
@export var paddingY: float = 1

# TODO: get the padding from the block size or make it autoamtic idk
@export var worldPaddingX: float = 50
@export var worldPaddingY: float = 50

# Use later to detect if the player has won
static var _block_instances: Array[Block] 	= []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Create a grid of blocks
	var block: PackedScene = preload("res://scenes/block/block.tscn")
	for row: int in blocksX:
		for column: int in blocksY:
			var blockInstance: Block = block.instantiate()
			
			blockInstance.set_size(Vector2(20, 15))
			var blockSize: Vector2 = blockInstance.get_size()
			
			blockInstance.position = Vector2(row * (blockSize.x + paddingX) + worldPaddingX,
											 column * (blockSize.y + paddingY) + worldPaddingY)
			add_child(blockInstance)
	
	# TODO: add automatic spawning function that fills a certain portion of the screen with blocks
	#var viewportSize: Vector2 = get_viewport().size

# Adds a block to the block instances array
static func add_block(block_instance: Block) -> void:
	if not block_instance in _block_instances:
		_block_instances.append(block_instance)
		
# Removes a block from the block instances array
static func remove_block(block_instance: Block) -> void:
	if block_instance in _block_instances:
		_block_instances.erase(block_instance)

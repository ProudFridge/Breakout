extends Node
class_name BlockManager

@export var blockAmount: Vector2i = Vector2i(3,2)
@export var blockPadding: Vector2 = Vector2(10, 10)
@export var gridPadding: Vector2 = Vector2(50, 50)
@export var showGridArea: bool = false

@onready var grid_area: ColorRect = $GridArea

var block: PackedScene = preload("res://scenes/block/block.tscn")

# Use later to detect if the player has won
static var _block_instances: Array[Block] 	= []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var viewportSize: Vector2 = get_viewport().size
	grid_area.visible = showGridArea
		
	generate_grid(Vector2(viewportSize.x, 300), blockAmount, blockPadding, gridPadding)

# Instantiates a grid of blocks 
func generate_grid(gridSize: Vector2, blockAmount: Vector2, blockPadding: Vector2, gridPadding: Vector2 ) -> void:
	grid_area.size = gridSize

	var blockSize: Vector2
	blockSize.x = (gridSize.x - 2 * gridPadding.x - (blockAmount.x - 1) * blockPadding.x) / blockAmount.x
	blockSize.y = (gridSize.y - 2 * gridPadding.y - (blockAmount.y - 1) * blockPadding.y) / blockAmount.y 
	
	for row: int in blockAmount.x:
		for column: int in blockAmount.y:
			var blockInstance: Block = block.instantiate()	
			blockInstance.set_size(blockSize)

			blockInstance.position.x = row * (blockPadding.x + blockSize.x) + gridPadding.x + blockSize.x / 2
			blockInstance.position.y = column * (blockPadding.y + blockSize.y) + gridPadding.y + blockSize.y / 2
			
			add_child(blockInstance)

# Adds a block to the block instances array
static func add_block(block_instance: Block) -> void:
	if not block_instance in _block_instances:
		_block_instances.append(block_instance)
		
# Removes a block from the block instances array
static func remove_block(block_instance: Block) -> void:
	if block_instance in _block_instances:
		_block_instances.erase(block_instance)
		
func toggle_grid_area_visibilty() -> void:
	grid_area.visibile = !grid_area.visible

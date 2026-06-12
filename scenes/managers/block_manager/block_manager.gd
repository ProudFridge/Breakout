extends Node
class_name BlockManager

@export var block_amount: Vector2i = Vector2i(3,2)
@export var block_padding: Vector2 = Vector2(10, 10)
@export var grid_padding: Vector2 = Vector2(50, 50)
@export var grid_height: float = 400
@export var grid_area: Vector2
@export var show_grid_area: bool = false

@onready var grid_area_highlight: ColorRect = $GridArea

var block: PackedScene = preload("res://scenes/block/block.tscn")

# Use later to detect if the player has won
static var _block_instances: Array[Block] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid_area_highlight.visible = show_grid_area
	
	# Temporary fix for the area of the grid
	var viewportSize: Vector2 = get_viewport().size
	grid_area = Vector2(viewportSize.x, grid_height)
		
	generate_grid(Vector2(viewportSize.x, grid_height), block_amount, block_padding, grid_padding)

# Instantiates a grid of blocks 
func generate_grid(gridSize: Vector2, blockAmount: Vector2, blockPadding: Vector2, gridPadding: Vector2 ) -> void:
	grid_area_highlight.size = gridSize

	var blockSize: Vector2
	blockSize.x = (gridSize.x - 2 * gridPadding.x - (blockAmount.x - 1) * blockPadding.x) / blockAmount.x
	blockSize.y = (gridSize.y - 2 * gridPadding.y - (blockAmount.y - 1) * blockPadding.y) / blockAmount.y 
	
	for row: int in blockAmount.x:
		for column: int in blockAmount.y:
			# Make the blocks spawn in a rainbow
			var color: Color = Color.from_hsv(lerp(0, 1, float(column) / blockAmount.y),0.5,1,1)
			var bPosition: Vector2
			bPosition.x = row * (blockPadding.x + blockSize.x) + gridPadding.x + blockSize.x / 2
			bPosition.y = column * (blockPadding.y + blockSize.y) + gridPadding.y + blockSize.y / 2
			
			instantiate_block(bPosition, blockSize, color)

# Adds a block to the block instances array
static func add_block(block_instance: Block) -> void:
	if not block_instance in _block_instances:
		_block_instances.append(block_instance)
		
# Removes a block from the block instances array
static func remove_block(block_instance: Block) -> void:
	if block_instance in _block_instances:
		_block_instances.erase(block_instance)
		
# Deletes all the blocks in the block istances array and remove their references
static func clear_grid() -> void:
	for b: Block in _block_instances:
		b.delete()
	_block_instances.clear()
		
# Toggles the visibility of the color rect that represents the grid area
func toggle_grid_area_visibilty() -> void:
	grid_area_highlight.visible = not grid_area_highlight.visible
	
func instantiate_block(position: Vector2, size: Vector2, color: Color) -> void:
	var blockInstance: Block = block.instantiate()	
	
	blockInstance.set_size(size)
	blockInstance.initialColor = color
	blockInstance.position = position
	
	add_child(blockInstance)

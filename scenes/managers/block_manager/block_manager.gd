extends Node
class_name BlockManager
## Used to instantiate a block grid

@export var block_amount: Vector2i = Vector2i(3,2)
@export var block_padding: Vector2 = Vector2(10, 10)
@export var grid_padding: Vector2 = Vector2(10, 10)
#@export var grid_area: Vector2	
@export var show_grid_area: bool = false

@onready var grid_area_highlight: ColorRect = $GridArea

var block: PackedScene = preload("res://scenes/block/block.tscn")

# Use later to detect if the player has won
var _block_instances: Array[Block] = []
static var levels: Array = []

signal block_added(block: Block)
signal block_removed(block: Block)
signal level_won()

func _ready() -> void:
	grid_area_highlight.visible = show_grid_area

# Instantiates a grid of blocks 
func generate_grid(gridSize: Vector2, blockGrid: Array, blockPadding: Vector2, gridPadding: Vector2 ) -> void:
	grid_area_highlight.size = gridSize
	
	var blockAmountX: int = blockGrid.size()
	var blockAmountY: int = blockGrid[0].size()
	
	var blockSize: Vector2
	blockSize.x = (gridSize.x - 2 * gridPadding.x - (blockAmountX - 1) * blockPadding.x) / blockAmountX
	blockSize.y = (gridSize.y - 2 * gridPadding.y - (blockAmountY - 1) * blockPadding.y) / blockAmountY
	
	for row: int in blockAmountX:
		for column: int in blockAmountY:
			if blockGrid[row][column] == 1:
				# Make the blocks spawn in a rainbow
				var color: Color = Color.from_hsv(lerp(0, 1, float(column) / blockAmountY),0.5,1,1)
				var bPosition: Vector2
				bPosition.x = row * (blockPadding.x + blockSize.x) + gridPadding.x + blockSize.x / 2
				bPosition.y = column * (blockPadding.y + blockSize.y) + gridPadding.y + blockSize.y / 2
				
				instantiate_block(bPosition, blockSize, color)

# Adds a block to the block instances array
func add_block(block_instance: Block) -> void:
	if not block_instance in _block_instances:
		_block_instances.append(block_instance)
		block_added.emit(block_instance)

# Removes a block from the block instances array
func remove_block(block_instance: Block) -> void:
	if block_instance in _block_instances:
		_block_instances.erase(block_instance)
		block_removed.emit(block_instance)
		
		# Detects if the player has won
		if _block_instances.size() == 0:
			level_won.emit()

# Deletes all the blocks in the block istances array and remove their references
func clear_grid() -> void:
	for b: Block in _block_instances:
		b.delete()
	_block_instances.clear()

# Toggles the visibility of the color rect that represents the grid area
func toggle_grid_area_visibilty() -> void:
	grid_area_highlight.visible = not grid_area_highlight.visible
	
func instantiate_block(position: Vector2, size: Vector2, color: Color) -> void:
	var blockInstance: Block = block.instantiate()	
	self.add_block(blockInstance)
	
	blockInstance.blockManager = self
	blockInstance.set_size(size)
	blockInstance.initialColor = color
	blockInstance.position = position
	
	add_child(blockInstance)

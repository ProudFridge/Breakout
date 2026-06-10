extends Node2D

@onready var left_wall: CollisionShape2D = $WorldBoundary/Walls/LeftWall
@onready var right_wall: CollisionShape2D = $WorldBoundary/Walls/RightWall
@onready var bottom_wall: CollisionShape2D = $WorldBoundary/Walls/BottomWall
@onready var top_wall: CollisionShape2D = $WorldBoundary/Walls/TopWall

@onready var block_manager: BlockManager = $BlockManager

var blockAmountX: int
var blockAmountY: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set up the world boundaries otbe add the screen edges
	# Should change later for custom level sizes
	var viewportSize: Vector2 = get_viewport().size
	left_wall.position = Vector2(0,0)
	right_wall.position = Vector2(viewportSize.x, 0)
	bottom_wall.position = Vector2(0, viewportSize.y)
	top_wall.position = Vector2(0,0)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()

func _on_generate_grid_button_pressed() -> void:
	BlockManager.clear_grid()
	block_manager.generate_grid(block_manager.grid_area, Vector2(blockAmountX, blockAmountY), block_manager.block_padding, block_manager.grid_padding)

func _on_block_amount_x_text_changed(new_text: String) -> void:
	blockAmountX = int(new_text)

func _on_block_amount_y_text_changed(new_text: String) -> void:
	blockAmountY = int(new_text)

func _on_check_button_pressed() -> void:
	block_manager.toggle_grid_area_visibilty()

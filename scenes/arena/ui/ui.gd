extends Control

@export var blockManager: BlockManager
@export var gameManager: GameManager
@onready var lost_screen: Panel = $LostScreen
@onready var blockAreaSize: Vector2 = Vector2(Global.windowSize.x, 400)
var blockAmountX: int = 10
var blockAmountY: int = 10

@export var grid_utility: GridUtility

func _ready() -> void:
	
	grid_utility.blockAreaSize = blockAreaSize

func _on_generate_grid_button_pressed() -> void:
	blockManager.clear_grid()
	blockManager.generate_grid(blockAreaSize, LevelManager.generate_level(Vector2(blockAmountX, blockAmountY)), blockManager.block_padding, blockManager.grid_padding)

func _on_block_amount_x_text_changed(new_text: String) -> void:
	blockAmountX = int(new_text)
	print(blockAmountX)

func _on_block_amount_y_text_changed(new_text: String) -> void:
	blockAmountY = int(new_text)

func _on_check_button_pressed() -> void:
	blockManager.toggle_grid_area_visibilty()

func _on_game_manager_lost_game() -> void:
	lost_screen.visible = visible

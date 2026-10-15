extends Control

@export var blockManager: BlockManager
@export var gameManager: GameManager
@export var grid_utility: GridUtility
@onready var lost_screen: Panel = $LostScreen
@onready var color_rect: ColorRect = $ColorRect
var blockAmountX: int = 10
var blockAmountY: int = 10


func _ready() -> void:
	#color_rect.size = Global.windowSize
	grid_utility.blockAreaSize = gameManager.blockAreaSize
	gameManager.level_lost.connect(_on_game_manager_level_lost)	


func _on_game_manager_level_lost() -> void:
	lost_screen.visible = true

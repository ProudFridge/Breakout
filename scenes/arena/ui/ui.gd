extends Control

@export var blockManager: BlockManager
@export var gameManager: GameManager
@onready var lost_screen: Panel = $LostScreen
@onready var color_rect: ColorRect = $ColorRect
var blockAmountX: int = 10
var blockAmountY: int = 10

@export var grid_utility: GridUtility

func _ready() -> void:
	color_rect.size = Global.windowSize
	grid_utility.blockAreaSize = gameManager.blockAreaSize

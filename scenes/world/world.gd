extends Node2D

@onready var left_wall: CollisionShape2D = $WorldBoundary/Walls/LeftWall
@onready var right_wall: CollisionShape2D = $WorldBoundary/Walls/RightWall
@onready var bottom_wall: CollisionShape2D = $WorldBoundary/Walls/BottomWall
@onready var top_wall: CollisionShape2D = $WorldBoundary/Walls/TopWall
@onready var block_manager: BlockManager = $BlockManager
@onready var panel: Panel = $Control/Panel
@onready var ui: Control = $UI
@onready var header: Panel = $UI/Header
@onready var camera: Camera2D = $Camera2D

var blockAmountX: int = 10
var blockAmountY: int = 10

@export var gameAreaSize: Vector2 = Vector2(900, 900)
var blockAreaSize: Vector2 = Vector2(gameAreaSize.x, 400)
#@export var isCompact: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Centers camera
	BlockManager.load_levels()
	camera.position = gameAreaSize / 2
	
	# Makes the ui only fit in the game area
	ui.size = gameAreaSize
	
	# Try to fix later, tried to add a setting that made the viewport the same size as the game area + header
	#if isCompact:
		#ProjectSettings.set_setting("display/window/size/viewport_width", 200)
		#ProjectSettings.set_setting("display/window/size/viewport_height", gameAreaSize.y + header.size.y)
	
	header.position.y = -header.size.y
	panel.size = gameAreaSize
	block_manager.generate_grid(blockAreaSize, Vector2(blockAmountX, blockAmountY), block_manager.block_padding, block_manager.grid_padding)
	
	# Set up the world boundaries otbe add the screen edges
	# Should change later for custom level sizes
	left_wall.position = Vector2(0,0)
	right_wall.position = Vector2(gameAreaSize.x, 0)
	bottom_wall.position = Vector2(0, gameAreaSize.y)
	top_wall.position = Vector2(0,0)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()

func _on_generate_grid_button_pressed() -> void:
	BlockManager.clear_grid()
	block_manager.generate_grid(blockAreaSize, Vector2(blockAmountX, blockAmountY), block_manager.block_padding, block_manager.grid_padding)

func _on_block_amount_x_text_changed(new_text: String) -> void:
	blockAmountX = int(new_text)

func _on_block_amount_y_text_changed(new_text: String) -> void:
	blockAmountY = int(new_text)

func _on_check_button_pressed() -> void:
	block_manager.toggle_grid_area_visibilty()

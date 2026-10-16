extends Node
class_name GameManager
## Stores lives left and handle's ball respawn
# Should handle paddle and ball setup

@export var lives: int = 3
@export var blockManager: BlockManager
@onready var respawn_timer: Timer = $RespawnTimer
@onready var blockAreaSize: Vector2 = Vector2(Global.windowSize.x, 400)

const PADDLE: Resource = preload("uid://cvstwnwbs75xl")
const BALL: Resource = preload("uid://dpwwvkfv48suw")

static var currentLevel: int = 0
var ball: Ball

signal life_changed(lives: int)
signal level_lost()

func _ready() -> void:
	var paddle: Paddle = PADDLE.instantiate()
	ball = BALL.instantiate()
	
	paddle.position = Vector2(Global.windowSize.x / 2, Global.windowSize.y - 200)
	ball.position = Vector2(Global.windowSize.x / 2, paddle.position.y - 170)
	
	add_child(paddle)
	add_child(ball)
	
	blockManager.generate_grid(blockAreaSize, LevelManager.grid[currentLevel][0], blockManager.block_padding, blockManager.grid_padding)
	
	respawn_timer.timeout.connect(_on_timer_timeout)
	ball.died.connect(_on_ball_died)
	blockManager.level_won.connect(_on_block_manager_level_won)
	
	if ball == null:
		push_error("Ball slot cannot be empty")

func _on_ball_died() -> void:
	lives -= 1
	if lives == 0:
		level_lost.emit()
		life_changed.emit(lives)
		ball.freeze()
	else:
		life_changed.emit(lives)
		respawn_timer.start()

func _on_timer_timeout() -> void:
	ball.respawn()
	
func _on_block_manager_level_won() -> void:
	currentLevel += 1
	if currentLevel < LevelManager.levelCount:
		SwitcherSingleton.switch_from_to("res://scenes/arena/arena.tscn", SwitcherSingleton.TRANSITION_TYPE.SLIDE)
	

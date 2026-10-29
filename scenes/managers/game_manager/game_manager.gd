extends Node
class_name GameManager
## Stores lives left and handle's ball respawn
# Should handle paddle and ball setup

@export var lives: int = 3
@export var blockManager: BlockManager
@export var abilityManager: AbilityManager
@onready var respawn_timer: Timer = $RespawnTimer
@onready var blockAreaSize: Vector2 = Vector2(Global.windowSize.x, 450)

const PADDLE: Resource = preload("uid://cvstwnwbs75xl")
const BALL: Resource = preload("uid://dpwwvkfv48suw")

static var difficulty: DIFFICULTY
static var currentLevel: int = 0
var ball: Ball
var paddle: Paddle
var initialPaddlePosition: Vector2
var initialBallPosition: Vector2

signal life_changed(lives: int)
signal level_lost()

func _ready() -> void:
	# Pauses the game for some time when the level starts
	process_mode = Node.PROCESS_MODE_DISABLED
	var timer: SceneTreeTimer = get_tree().create_timer(1.5)
	timer.timeout.connect(func() -> void: process_mode = PROCESS_MODE_ALWAYS)
	
	
	paddle = PADDLE.instantiate()
	ball = BALL.instantiate()
	
	initialPaddlePosition= Vector2(Global.windowSize.x / 2, Global.windowSize.y - 200)
	initialBallPosition = Vector2(Global.windowSize.x / 2, initialPaddlePosition.y - ball.ballRadius * 2)
	
	paddle.position = initialPaddlePosition
	ball.position = initialBallPosition
	
	add_child(paddle)
	add_child(ball)
	
	if difficulty == DIFFICULTY.EASY:
		paddle.set_length(90)
	elif difficulty == DIFFICULTY.NORMAL:
		paddle.set_length(75)
	else:
		paddle.set_length(60)
	
	abilityManager.paddle = paddle
	
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
	print(currentLevel)
	if currentLevel < LevelManager.levelCount :
		SwitcherSingleton.switch_from_to("res://scenes/arena/arena.tscn", SwitcherSingleton.TRANSITION_TYPE.SLIDE)
	elif currentLevel >= LevelManager.levelCount :
		SwitcherSingleton.switch_from_to("res://scenes/congrats/congrats.tscn", SwitcherSingleton.TRANSITION_TYPE.SLIDE)
	
enum DIFFICULTY {
	EASY,
	NORMAL,
	HARD
}

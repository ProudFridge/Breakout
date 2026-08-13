extends Node
class_name GameManager
## Stores lives left and handle's ball respawn

@export var lives: int = 3
@export var ball: Ball

@onready var respawn_timer: Timer = $RespawnTimer

var currentLevel: int = 0

signal life_changed(lives: int)
signal lost_game()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	respawn_timer.timeout.connect(_on_timer_timeout)
	ball.died.connect(_on_ball_died)
	
	if ball == null:
		push_error("Ball slot cannot be empty")

func _on_ball_died() -> void:
	lives -= 1
	if lives == 0:
		lost_game.emit()
		ball.freeze()
	else:
		life_changed.emit(lives)
		respawn_timer.start()

func _on_timer_timeout() -> void:
	ball.respawn()

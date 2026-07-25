extends Label

@export var gameManager: GameManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = str(gameManager.lives)
	gameManager.life_changed.connect(_on_game_manager_life_changed)

func _on_game_manager_life_changed(lives: int) -> void:
	text = str(lives)

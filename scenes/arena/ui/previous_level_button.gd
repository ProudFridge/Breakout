extends Button


@export var gameManager: GameManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_on_skip_level_button_pressed)


func _on_skip_level_button_pressed() -> void:
	if gameManager.currentLevel >= 1:
		gameManager.currentLevel -= 1
		SwitcherSingleton.switch_from_to("res://scenes/arena/arena.tscn", SwitcherSingleton.TRANSITION_TYPE.SLIDE)	

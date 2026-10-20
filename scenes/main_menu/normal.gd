extends Button


func _ready() -> void:
	self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	Ball.defaultBallSpeed = 450
	GameManager.difficulty = GameManager.DIFFICULTY.NORMAL
	SwitcherSingleton.switch_from_to("res://scenes/arena/arena.tscn",SwitcherSingleton.TRANSITION_TYPE.SLIDE)

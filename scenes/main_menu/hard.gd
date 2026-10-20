extends Button


func _ready() -> void:
	self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	Ball.defaultBallSpeed = 550
	GameManager.difficulty = GameManager.DIFFICULTY.HARD
	SwitcherSingleton.switch_from_to("res://scenes/arena/arena.tscn",SwitcherSingleton.TRANSITION_TYPE.SLIDE)

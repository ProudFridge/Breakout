extends Button

func _ready() -> void:
	self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	Ball.defaultBallSpeed = 400
	GameManager.difficulty = GameManager.DIFFICULTY.EASY
	BlockManager.abilitySpawnChances = {
		Ability.AbilityType.CLONE: 0.5,
		Ability.AbilityType.GROW: 0.3
		}
	BlockManager.blockHealth = 1
	SwitcherSingleton.switch_from_to("res://scenes/arena/arena.tscn",SwitcherSingleton.TRANSITION_TYPE.SLIDE)

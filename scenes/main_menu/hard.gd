extends Button

func _ready() -> void:
	self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	Ball.defaultBallSpeed = 550
	GameManager.difficulty = GameManager.DIFFICULTY.HARD
	BlockManager.abilitySpawnChances = {
		Ability.AbilityType.CLONE: 0.2,
		Ability.AbilityType.GROW: 0.1
		}
	BlockManager.blockHealth = 2
	SwitcherSingleton.switch_from_to("res://scenes/arena/arena.tscn",SwitcherSingleton.TRANSITION_TYPE.SLIDE)

extends Button

func _ready() -> void:
	self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	SwitcherSingleton.switch_from_to("res://scenes/main_menu/main_menu.tscn", SwitcherSingleton.TRANSITION_TYPE.SLIDE)
	GameManager.currentLevel = 0

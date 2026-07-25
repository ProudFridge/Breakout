extends Button

@onready var main_menu: Control = $"../.."

func _ready() -> void:
	self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	SwitcherSingleton.switch_from_to(main_menu, "res://scenes/arena/arena.tscn")

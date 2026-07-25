extends Button

@onready var main_menu: Control = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("fffff")
	self.pressed.connect(_on_pressed)


func _on_pressed() -> void:
	SwitcherSingleton.switch_to(main_menu, "res://scenes/arena/arena.tscn")

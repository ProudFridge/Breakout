extends Button

@onready var arena: Node2D = $"../../../../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_on_restart_button_pressed)

func _on_restart_button_pressed() -> void:
	print(get_tree().root)
	SwitcherSingleton.switch_from_to(arena, "res://scenes/arena/arena.tscn")

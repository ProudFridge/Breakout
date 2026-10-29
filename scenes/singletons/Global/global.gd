extends Node

var windowSize: Vector2

func _ready() -> void:
	#windowSize = get_window().size
	windowSize = Vector2(650, 950)
	print(windowSize)
	LevelManager.load_levels()

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, Global.windowSize), Color.DIM_GRAY, false, 5)

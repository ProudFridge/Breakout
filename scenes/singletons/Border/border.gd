extends Node2D

func _ready() -> void:
	z_index = 10

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, Global.windowSize), Color.DIM_GRAY, false, 5)

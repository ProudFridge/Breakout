extends Control

@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.offset_transform_enabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.offset_transform_rotation = 0.2 * sin(float(Time.get_ticks_msec()) / 1000)
	var num: float = 0.2 * sin(float(Time.get_ticks_msec()) / 500) + 1
	label.offset_transform_scale = Vector2(pow(num, 2) , pow(num, 2))
	pass

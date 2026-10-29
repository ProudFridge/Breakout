extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !OS.is_debug_build():
		hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends CanvasLayer

var gameStarted: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	visible = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("space") && !gameStarted:
		get_tree().paused = false
		hide()
		gameStarted = true

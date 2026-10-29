extends Node

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if OS.is_debug_build():
		if event.is_action_pressed("quit"):
			get_tree().quit()

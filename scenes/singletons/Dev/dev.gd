extends Node

func _input(event: InputEvent) -> void:
	if OS.is_debug_build():
		if event.is_action_pressed("quit"):
			get_tree().quit()

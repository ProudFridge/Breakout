extends Label

func _process(delta: float) -> void:
	text = str(BlockManager._block_instances.size())

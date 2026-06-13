extends Label

func _process(_delta: float) -> void:
	text = str(BlockManager._block_instances.size())

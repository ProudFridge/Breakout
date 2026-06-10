extends RichTextLabel

# Called when the node enters the scene tree for the first time.

# Replace with static signal from the BlockManager class
func _process(delta: float) -> void:
	text = str(BlockManager._block_instances.size())

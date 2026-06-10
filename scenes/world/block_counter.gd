extends RichTextLabel

# Replace with static signal from the BlockManager class
# Maybe by creating a scritpt singleton and storing a reference to the a BlockManager node
func _process(delta: float) -> void:
	text = str(BlockManager._block_instances.size())

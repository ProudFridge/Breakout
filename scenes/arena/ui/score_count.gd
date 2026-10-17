extends Label

@export var block_manager: BlockManager

func _ready() -> void:
	text = "0"
	block_manager.block_removed.connect(_on_block_manager_block_removed)

func _on_block_manager_block_removed(_block: Block, ball: Ball) -> void:
	text = str(int(text) + 10)

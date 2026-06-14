extends Label

@onready var block_manager: BlockManager = $"../../../../../BlockManager"

func _ready() -> void:
	text = "0"
	block_manager.block_removed.connect(_on_block_manager_block_removed)

func _on_block_manager_block_removed(block: Block) -> void:
	text = str(int(text) + 10)

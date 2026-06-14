extends Label

@onready var block_manager: BlockManager = $"../../../../../BlockManager"

func _ready() -> void:
	block_manager.block_added.connect(_on_block_manager_block_added)
	block_manager.block_removed.connect(_on_block_manager_block_removed)

func _on_block_manager_block_added(_block: Block) -> void:
	text = str(block_manager._block_instances.size())
	
func _on_block_manager_block_removed(_block: Block) -> void:
	text = str(block_manager._block_instances.size())

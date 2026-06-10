extends CharacterBody2D
class_name Block

@export var health: float = 2

@onready var label: Label = $Label

func _ready() -> void:
	BlockManager.add_block(self)
	label.text = str(int(round(health)))

# Decreases the block's health
func take_damage(damage: float) -> void:
	health = health - damage
	if health == 0:
		BlockManager.remove_block(self)
		delete()
	label.text = str(int(round(health)))

# Sets the block's size
func set_size(newSize: Vector2) -> void:
	$CollisionShape2D.shape.size = newSize
	$MeshInstance2D.scale = newSize

# Return's the block's size
func get_size() -> Vector2:
	return $CollisionShape2D.shape.size

# Deletes the block
func delete() -> void:
	queue_free()

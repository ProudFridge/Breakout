extends CharacterBody2D
class_name Block

@export var health: float = 2
var initialHealth: float
var initialColor: Color
var blockManager: BlockManager


var effectTime: float = 0.2
var effectScale: Vector2 = Vector2(0.7, 0.7)

@onready var label: Label = $Label
@onready var mesh: MeshInstance2D = $MeshInstance2D

func _ready() -> void:
	mesh.modulate = initialColor
	initialHealth = health
	#BlockManager.add_block(self)
	update_health_label()

# Decreases the block's health
func take_damage(damage: float) -> void:
	health = health - damage
	if health == 0:
		blockManager.remove_block(self)
		delete()
	update_health_label()	
	
	# Make the color become more red as it takes damage
	mesh.modulate = mesh.modulate.lerp(Color(1,0,0), (initialHealth - health) / initialHealth)
	apply_hit_effects()
	
# Sets the block's size
func set_size(newSize: Vector2) -> void:
	$CollisionShape2D.shape.size = newSize
	$MeshInstance2D.mesh.size = newSize
	
# Return's the block's size
func get_size() -> Vector2:
	return $CollisionShape2D.shape.size

# Deletes the block
func delete() -> void:
	queue_free()
	
func update_health_label() -> void:
	label.text = str(int(round(health)))
	
func apply_hit_effects() -> void:
	mesh.scale = effectScale
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(mesh, "scale", Vector2(1,1), effectTime).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_callback(func() -> void: tween.kill())

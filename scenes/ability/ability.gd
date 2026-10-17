extends CharacterBody2D
class_name Ability

var abilityType: AbilityType
var applyAbility: Callable

const ABILITY: Resource = preload("uid://qlrevi4e1u2")

func _ready() -> void:
	velocity = Vector2(0, 100)

func _physics_process(delta: float) -> void:
	move_and_slide()


func create(position: Vector2, type: AbilityType) -> void:
	var ability: Ability = ABILITY.instantiate()
	ability.position = position
	
func use_ability() -> void:
	print("32")

enum AbilityType {
	NONE,
	CLONE,
	GROW
}

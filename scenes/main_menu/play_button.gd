extends Button

@onready var main_menu: Control = $"../.."

func _ready() -> void:
	self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	var transitionRect: Resource = load("res://scenes/transition_rects/horizontal_transition_rect.tscn")
	var instance: Node = transitionRect.instantiate()
	instance.transitionTime = 1
	instance.startTransitionDone.connect(SwitcherSingleton.switch_from_to.bind("res://scenes/arena/arena.tscn"))
	get_tree().get_root().add_child(instance)
	

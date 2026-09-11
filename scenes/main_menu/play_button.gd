extends Button

@onready var main_menu: Control = $"../.."

func _ready() -> void:
	self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	var transitionRect: TransitionRect = TransitionRect.new()
	transitionRect.transitionTime = 1
	transitionRect.set_shader(TransitionRect.TRANSITION_SHADER.get("HORIZONTAL"))
	transitionRect.startTransitionDone.connect(SwitcherSingleton.switch_from_to.bind("res://scenes/arena/arena.tscn"))
	
	get_tree().get_root().add_child(transitionRect)
	
	# Uncomment this line and comment the above lines to disable transitions
	#SwitcherSingleton.switch_from_to("res://scenes/arena/arena.tscn")

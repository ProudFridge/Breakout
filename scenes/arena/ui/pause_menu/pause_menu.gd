extends CanvasLayer

@export var startMessage: CanvasLayer
@export var resume: Button
@export var main_menu: Button
@export var quit: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resume.pressed.connect(_on_resume_pressed)
	main_menu.pressed.connect(_on_main_menu_pressed)
	quit.pressed.connect(_on_quit_pressed)
	hide()

func _on_resume_pressed() -> void:
	get_tree().paused = false
	hide()	

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	hide()
	SwitcherSingleton.switch_from_to("res://scenes/main_menu/main_menu.tscn", SwitcherSingleton.TRANSITION_TYPE.SLIDE)

func _on_quit_pressed() -> void:
	get_tree().quit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape") and startMessage.gameStarted:
		get_tree().paused = !get_tree().paused
		visible = !visible

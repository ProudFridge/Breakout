extends Node
class_name DashComponent

var characterBody: CharacterBody2D
@onready var dash_timer: Timer = $DashTimer

@export var dashSpeed: float = 1200
@export var dashTime: float = 0.12

func _ready() -> void:
	dash_timer.wait_time = dashTime
	dash_timer.connect("timeout", _on_dash_timer_timeout)
	
	characterBody = get_parent()
	
	# TODO: uncomment this part when we seperate movement functionality into components
	#for node: Node in get_parent().get_children():
		#if node is CharacterBody2D:
			#characterBody = node	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("dash"):
		dash_start()

func _on_dash_timer_timeout() -> void:
	dash_finished()
	
func dash_start() -> void:
	characterBody.SPEED = dashSpeed
	dash_timer.start()

func dash_finished() -> void:
	characterBody.SPEED = characterBody.oriSpeed

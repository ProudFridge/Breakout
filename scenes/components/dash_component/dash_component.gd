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

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("dash") and characterBody.velocity != Vector2.ZERO:
		dash_start()
		
func _on_dash_timer_timeout() -> void:
	dash_finished()
	characterBody.scale = Vector2(1,1)
	
func dash_start() -> void:
	characterBody.SPEED = dashSpeed
	dash_timer.start()
	
	# Tween the character body's scale
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(characterBody, "scale", Vector2(1.4, 0.7), dashTime * 0.5)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SINE)

func dash_finished() -> void:
	characterBody.SPEED = characterBody.oriSpeed
	
	# Reset's the character body's scale
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(characterBody, "scale", Vector2(1, 1), dashTime * 0.5)
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_SINE)

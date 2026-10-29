extends VBoxContainer

var totalTime: float = 0.15
var trans: Tween.TransitionType = Tween.TRANS_EXPO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var children: Array[Node] = get_children()
	var i: int = 0
	
	(children[0] as Control).grab_focus.call_deferred()
	
	for button: Button in children:
		# Set animations
		var tween: Tween
		
		button.offset_transform_enabled = true
		button.button_down.connect(func() -> void:
			if tween: tween.kill()
			button.offset_transform_scale = Vector2(0.95, 0.95)
			AudioManager.play_sound("buttonPress")
			)
		
		button.button_up.connect(func() -> void:
			tween = get_tree().create_tween()
			tween.tween_property(button, "offset_transform_scale", Vector2(1,1), totalTime).set_trans(trans).set_ease(Tween.EASE_OUT))

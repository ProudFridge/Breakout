extends VBoxContainer

var totalTime: float = 0.3
var trans: Tween.TransitionType = Tween.TRANS_EXPO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button: Button in self.get_children():
		var tween: Tween
		
		button.offset_transform_enabled = true
		button.button_down.connect(func() -> void:
			if tween: tween.kill()
			button.offset_transform_scale = Vector2(0.95, 0.95)
			AudioManager.play_sound("press")
			)
		
		button.button_up.connect(func() -> void:
			tween = get_tree().create_tween()
			tween.tween_property(button, "offset_transform_scale", Vector2(1,1), totalTime / 2).set_trans(trans).set_ease(Tween.EASE_OUT))

extends VBoxContainer

var totalTime: float = 0.3
var trans: Tween.TransitionType = Tween.TRANS_EXPO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button: Button in self.get_children():
		var tween: Tween
		var rotTween: Tween
		
		# Make buttons wobble by modifying their rotation over time
		button.offset_transform_enabled = true
		#button.mouse_entered.connect(func() -> void: get_tree().create_tween().tween_property(button, "offset_transform_scale", Vector2(0.9,0.9), 0.2).set_trans(Tween.TRANS_EXPO))
		#button.mouse_exited.connect(func() -> void: get_tree().create_tween().tween_property(button, "offset_transform_scale", Vector2(1,1), 0.2).set_trans(Tween.TRANS_SINE))
		button.button_down.connect(func() -> void:
			if tween: tween.kill()
			button.offset_transform_scale = Vector2(0.95, 0.95)
			button.offset_transform_rotation = randf_range(-0.1, 0.1)
			AudioManager.play_sound("press")
			)
		
		button.button_up.connect(func() -> void:
			tween = get_tree().create_tween()
			tween.tween_property(button, "offset_transform_scale", Vector2(1,1), totalTime / 2).set_trans(trans).set_ease(Tween.EASE_OUT)
			
			rotTween = get_tree().create_tween()
			rotTween.tween_property(button, "offset_transform_rotation", 0, totalTime / 3).set_trans(trans).set_ease(Tween.EASE_OUT)
			)
			
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var i: int = 0
	var phaseDiff: float = 0.5
	for button: Button in self.get_children():
		button.offset_transform_position = Vector2(0, 3 * sin(3 * Time.get_ticks_msec() / 1000.0 + phaseDiff * i))
		i += 1
	pass

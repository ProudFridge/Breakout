extends ColorRect
class_name TransitionRect

var transitionTime: float

static var TRANSITION_SHADER: Dictionary = {
	"HORIZONTAL": "res://shaders/horizontal_transition.gdshader"
}

signal startTransitionDone
signal endTransitionDone

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	z_index = 10
	size = get_viewport().get_visible_rect().size
	
	var shaderMaterial: ShaderMaterial = material 
	
	if shaderMaterial == null:
		push_error("ShaderMaterial is null")
	else:
		var startTween: Tween = get_tree().create_tween()
		var endTween: Tween = get_tree().create_tween()
		
		startTween.set_ease(Tween.EASE_OUT)
		startTween.set_trans(Tween.TRANS_BACK)
		
		endTween.set_ease(Tween.EASE_OUT)
		endTween.set_trans(Tween.TRANS_BACK)
		
		startTween.tween_method(set_start_value, 0.0, 1.0, transitionTime)
		startTween.tween_callback(startTransitionDone.emit)
		
		endTween.tween_method(set_end_value, 0.0, 1.0, transitionTime).set_delay(transitionTime)
		endTween.tween_callback(endTransitionDone.emit)
		endTween.tween_callback(queue_free)

## Sets the shader
func set_shader(shaderPath: String) -> void:
	var shaderMaterial: ShaderMaterial = ShaderMaterial.new()
	shaderMaterial.shader = load(shaderPath)
	print(shaderMaterial.shader)
	self.material = shaderMaterial

func set_start_value(startProgressValue: float) -> void:
	(material as ShaderMaterial).set_shader_parameter("startProgress", startProgressValue)

func set_end_value(endProgressValue: float) -> void:
	(material as ShaderMaterial).set_shader_parameter("endProgress", endProgressValue)

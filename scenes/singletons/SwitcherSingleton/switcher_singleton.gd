# Intended to be used as a singleton
# Works by deleted a scene and instancing a new one
# Code taken and adapted from https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html
extends Node
	
var current_scene: Node = null
	
func _ready() -> void:
	var root: Window = get_tree().root
	# Using a negative index counts from the end, so this gets the last child node of `root`.
	current_scene = root.get_child(-1)	
	print(current_scene.name)
	
## Deletes the sourceScene and instances the targetScene
func switch_from_to(targetScene: String, transitionType: TRANSITION_TYPE = TRANSITION_TYPE.NONE) -> void:
	# Defer the load to a later time, when we can be sure that no code from the current scene is running
	deferred_switch_to.call_deferred(targetScene, transitionType)

func deferred_switch_to(targetScene: String, transitionType: TRANSITION_TYPE) -> void:
	if transitionType != TRANSITION_TYPE.NONE:
		# Adds the transitionRect into a canvasLayer so it stays idnependant of the camera's position
		# TODO: group this into a function, it's messy
		var canvasLayer: CanvasLayer = CanvasLayer.new()
		var transitionRect: TransitionRect = TransitionRect.new(0.5)
		canvasLayer.add_child(transitionRect)
		
		transitionRect.set_shader(TransitionRect.TRANSITION_SHADER.get("HORIZONTAL"))
		transitionRect.startTransitionDone.connect(SwitcherSingleton.switch_from_to.bind("res://scenes/arena/arena.tscn"))
	
		get_tree().get_root().add_child(canvasLayer)
	else:
		# It is now safe to remove the current scene.
		current_scene.free()
		
		# Load the new scene.
		var s: PackedScene = ResourceLoader.load(targetScene)
		
		# Instance the new scene.
		current_scene = s.instantiate()

		print("Scene switched to: ", current_scene.name)
		
		# Add it to the active scene, as child of root.
		get_tree().root.add_child(current_scene)

		# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
		get_tree().current_scene = current_scene
		
## Defines the transition type used when switching scenes
enum TRANSITION_TYPE {
	NONE,
	SLIDE
}

class TransitionRect extends ColorRect:
	var transitionTime: float

	static var TRANSITION_SHADER: Dictionary = {
		"HORIZONTAL": "res://shaders/horizontal_transition.gdshader"
	}
	
	signal startTransitionDone
	signal endTransitionDone

	func _init(transTime: float) -> void:
		self.transitionTime = transTime

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
		

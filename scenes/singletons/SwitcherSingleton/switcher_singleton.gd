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

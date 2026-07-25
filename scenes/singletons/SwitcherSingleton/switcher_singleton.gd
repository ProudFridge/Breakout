# Intended to be used as a singleton
# Works by deleted a scene and instancing a new one
# Code taken and adapted from https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html
extends Node

## Deletes the sourceScene and instances the targetScene
func switch_to(sourceScene: Node, targetScene: String) -> void:
	# Defer the load to a later time, when we can be sure that no code from the current scene is running
	deferred_switch_to.call_deferred(sourceScene, targetScene)

func deferred_switch_to(sourceScene: Node, targetScene: String) -> void:
	# Remove the current scene.
	sourceScene.free()
	
	# Load the new scene.
	var scene: PackedScene = ResourceLoader.load(targetScene)
	
	# Instance the new scene.
	var instantiatedScene: Node = scene.instantiate()
	
	# Add it to the active scene, as child of root.
	get_tree().root.add_child(instantiatedScene)
	
	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = instantiatedScene
	print("hiii")

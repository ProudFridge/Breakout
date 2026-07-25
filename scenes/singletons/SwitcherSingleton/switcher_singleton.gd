# Intended to be used as a singleton
# Works by deleted a scene and instancing a new one
# Code taken and adapted from https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html
extends Node

## Deletes the sourceScene and instances the targetScene
func switch_from_to(sourceScene: Node, targetScene: String) -> void:
	# Defer the load to a later time, when we can be sure that no code from the current scene is running
	deferred_switch_to.call_deferred(sourceScene, targetScene)

func deferred_switch_to(sourceScene: Node, targetScene: String) -> void:
	# Remove the current scene.
	sourceScene.free()
	
	# Load the new scene.
	var scene: PackedScene = ResourceLoader.load(targetScene)
	
	# Instance the new scene.
	var instantiatedScene: Node = scene.instantiate()
	
	# Add it to the active scene, as child of the curretn scene(game).
	get_tree().current_scene.add_child(instantiatedScene)
	
	print("Scene switched to: ", instantiatedScene.name)

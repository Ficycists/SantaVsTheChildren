extends Control

# Assuming you are in a script attached to a node in the scene

# Change to a new scene by providing the path to the scene
func change_scene() -> void:
	# Get the current SceneTree
	var tree = get_tree()
	
	# Change the scene
	tree.change_scene_to_file("res://scenes/test_scene_3.tscn")
func reset_level() -> void:
	var tree = get_tree()
	tree.change_scene_to_file("res://scenes/test_scene_1.tscn")

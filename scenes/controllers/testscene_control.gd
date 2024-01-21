extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

# Assuming you are in a script attached to a node in the scene

# Change to a new scene by providing the path to the scene
func change_scene() -> void:
	# Get the current SceneTree
	var tree = get_tree()
	
	# Change the scene
	tree.change_scene_to_file("res://scenes/test_scene_2.tscn")

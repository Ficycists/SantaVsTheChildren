extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_key_pressed(KEY_Z):
		var tree = get_tree()
		var scenePath: String = str(tree.current_scene.scene_file_path)
		var newscenePath = "res://scenes/credits.tscn"
		print(newscenePath)
		$Control.change_scene(newscenePath)
		

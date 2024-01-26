extends Node2D

#func _ready():

	
func _process(_delta):
	if Input.is_key_pressed(KEY_Y):
		var tree = get_tree()
		var scenePath: String = str(tree.current_scene.scene_file_path)
		var newscenePath = "res://scenes/test_scene_"+str(int(scenePath[25])+1)+".tscn"
		print(newscenePath)
		$Control.change_scene(newscenePath)
		

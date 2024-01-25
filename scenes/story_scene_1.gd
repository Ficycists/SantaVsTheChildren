extends Node2D

#func _ready():

	
func _process(_delta):
	if Input.is_action_pressed("ui_accept"):
		var tree = get_tree()
		var scenePath: String = str(tree.current_scene.scene_file_path)
		var newscenePath = "res://scenes/test_scene_"+str(int(scenePath[25])+1)+".tscn"
		$Control.change_scene(newscenePath)
		

extends Node2D

@onready var color_rect = $ColorRect

var next_active : bool = false

func _ready():
	color_rect.active = true;
	
var count : int = 0
	
func nextScene():
	var tree = get_tree()
	var scenePath: String = str(tree.current_scene.scene_file_path)
	var newscenePath = "res://scenes/test_scene_"+str(int(scenePath[25])+1)+".tscn"
	print(newscenePath)
	$Control.change_scene(newscenePath)
	
func _process(_delta):
	if Input.is_key_pressed(KEY_Z):
		
		pass
		
	elif z_pressed == true:
		z_pressed = false
			
			

var z_pressed : bool = false

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			print_debug(z_pressed)
			if event.keycode == KEY_Y:
				nextScene()
			elif event.keycode == KEY_Z && z_pressed == false:
				z_pressed = true
				color_rect.pcess()
				if next_active:
					match count:
						0:
							color_rect = $ColorRect1
							count += 1
						1:
							color_rect = $ColorRect2
							count += 1
						2:
							color_rect = $ColorRect2
							count += 1
						3:
							color_rect = $ColorRect3
							count += 1
						4:
							color_rect = $ColorRect4
							count += 1
						5:
							nextScene()
					color_rect.active = true
					next_active = false
			elif event.keycode == KEY_Z && z_pressed == true:
				pass
			else:
				z_pressed = false
			
			
		

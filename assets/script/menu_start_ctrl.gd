extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _process(_delta: float) -> void:
	if Input.is_action_pressed("character_select"):  # Change "ui_accept" to the desired key action
		get_tree().change_scene_to_file("res://scenes/test_scene.tscn")

extends Area2D

#signal level_done
@onready var control = $"../Control"

func _on_body_entered(body):
	if body.name == "Santa":
		control.change_scene("res://scenes/test_scene_2.tscn")
		#level_done.emit()

extends Area2D

signal level_done

func _on_body_entered(body):
	if body.name == "Santa":
		level_done.emit()

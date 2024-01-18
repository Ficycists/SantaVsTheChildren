extends Area2D


signal powerup_speed_sig


func _on_body_entered(body):
	if body.name =="Santa":
		powerup_speed_sig.emit()
		queue_free()

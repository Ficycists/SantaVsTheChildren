extends Area2D


signal powerup_speed_sig


func _on_body_entered(body):
	powerup_speed_sig.emit()
	queue_free()

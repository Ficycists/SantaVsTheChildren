extends Area2D

signal powerup_reload_sig

func _on_body_entered(body):
	if body.name =="Santa":
		powerup_reload_sig.emit()
		queue_free()

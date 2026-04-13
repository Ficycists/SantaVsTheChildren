extends Area2D

signal powerup_protect_sig

func _on_body_entered(body):
	if body.name =="Santa":
		powerup_protect_sig.emit()
		queue_free()

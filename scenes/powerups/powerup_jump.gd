extends Area2D

signal powerup_jump_sig


func _on_body_entered(body):
	if body.name =="Santa":
		powerup_jump_sig.emit()
		queue_free()


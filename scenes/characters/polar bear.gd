extends Area2D

signal die



func _on_body_entered(body):
	if body.name=="Santa":
		die.emit()

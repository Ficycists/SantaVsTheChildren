extends Area2D

signal missile_frag_collected




func _on_body_entered(body):
	if body.name =="Santa":
		missile_frag_collected.emit()
		queue_free()

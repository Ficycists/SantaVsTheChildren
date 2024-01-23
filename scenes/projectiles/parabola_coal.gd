extends RigidBody2D

func _on_area_2_dcoal_area_entered(area):
	queue_free()

func _on_area_2_dcoal_body_entered(body):
	if body.name=="BaseLevelTest":
		queue_free()

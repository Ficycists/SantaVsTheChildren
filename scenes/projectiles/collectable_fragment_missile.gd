extends Area2D

#func _ready():
	#position.x = randi_range(100,10000)

signal missile_fragment_collected

func _on_body_entered(body):
	if body.name =="Santa":
		missile_fragment_collected.emit()
		queue_free()

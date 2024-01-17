extends Node2D

var throw_coal_scene: PackedScene = preload("res://scenes/projectiles/parabola_coal.tscn")

func _on_santa_throw(pos):
	var pcoal = throw_coal_scene.instantiate()
	pcoal.position = pos
	add_child(pcoal)
	
func _ready():
	pass
	
func _process(delta):
	pass


func _on_santa_missile():
	pass # Replace with function body.

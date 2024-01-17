extends Node2D

var throw_coal_scene: PackedScene = preload("res://scenes/projectiles/parabola_coal.tscn")

func _on_santa_throw(pos,direction):
	var pcoal = throw_coal_scene.instantiate() as RigidBody2D
	pcoal.position = pos
	pcoal.linear_velocity = Vector2(direction*350,-350)
	$Projectiles.add_child(pcoal)
	
func _ready():
	pass
	
func _process(delta):
	pass


func _on_santa_missile():
	pass # Replace with function body.

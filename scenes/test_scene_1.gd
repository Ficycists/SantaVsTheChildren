extends Node2D

var throw_coal_scene: PackedScene = preload("res://scenes/projectiles/parabola_coal.tscn")

func _on_santa_throw(pos,direction):
	var pcoal = throw_coal_scene.instantiate() as RigidBody2D
	pcoal.position = pos
	pcoal.gravity_scale = 1
	pcoal.linear_velocity = Vector2(direction*350,-350)
	$Projectiles.add_child(pcoal)
	
func _ready():
	pass
	
func _process(delta):
	pass


func _on_santa_missile(pos,direction):
	var pcoal = throw_coal_scene.instantiate() as RigidBody2D
	pcoal.position = pos
	pcoal.gravity_scale = 0
	pcoal.linear_velocity = Vector2(direction*400,0)
	$Projectiles.add_child(pcoal)
	pass # Replace with function body.

extends Node2D

var throw_coal_scene: PackedScene = preload("res://scenes/projectiles/parabola_coal.tscn")
var death_scene: PackedScene = preload("res://scenes/temporary_deathscene.tscn")
var powerup_jump: PackedScene = preload("res://scenes/powerups/powerup_jump.tscn")

const coal_speed: int = 300
func _on_santa_throw(pos,direction):
	var pcoal = throw_coal_scene.instantiate() as RigidBody2D
	pcoal.position = pos
	pcoal.gravity_scale = 1
	pcoal.linear_velocity = Vector2(direction*(400+abs($Santa.velocity.x)),-200)
	$Projectiles.add_child(pcoal)
	
func _ready():
	pass
	
func _process(delta):
	#print($Santa.velocity.x)
	pass


func _on_santa_missile(pos,direction):
	var pcoal = throw_coal_scene.instantiate() as RigidBody2D
	pcoal.position = pos
	pcoal.gravity_scale = 0
	pcoal.linear_velocity = Vector2(direction*450,0)
	$Projectiles.add_child(pcoal)
	pass # Replace with function body.


func _on_santa_die():
	var dead = death_scene.instantiate()
	$tempdeathscene.add_child(dead)
	
	
	#pass # Replace with function body.

extends Node2D

var throw_coal_scene: PackedScene = preload("res://scenes/projectiles/parabola_coal.tscn")
var death_scene: PackedScene = preload("res://scenes/temporary_deathscene.tscn")
var powerup_jump: PackedScene = preload("res://scenes/powerups/powerup_jump.tscn")
var right_side_zombies: PackedScene = preload("res://scenes/characters/zombi_child.tscn")

const coal_speed: int = 300
func _on_santa_throw(pos,direction):
	var pcoal = throw_coal_scene.instantiate() as RigidBody2D
	pcoal.position = pos
	pcoal.gravity_scale = 1
	pcoal.linear_velocity = Vector2(direction*(400+abs($Santa.velocity.x)),-200)
	$Projectiles.add_child(pcoal)
	
const level_length: int = 100000
const level_scale: int =  100
var zombie_rate = 2

func _ready():
	$ZOMBIES/Zombie_timer.wait_time=zombie_rate
	$ZOMBIES/Zombie_timer.start()

func _process(_delta):
	zombie_rate = (level_length / $Santa.position.x) / level_scale 
	#print(zombie_rate)
	
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

func _on_zombie_timer_timeout():
	var right_zombie = right_side_zombies.instantiate() as CharacterBody2D
	right_zombie.position.x = $Santa.position.x + 1000
	$ZOMBIES.add_child(right_zombie)
	$ZOMBIES/Zombie_timer.wait_time=zombie_rate
	$ZOMBIES/Zombie_timer.start()

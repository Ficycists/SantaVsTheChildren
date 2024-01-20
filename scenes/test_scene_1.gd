extends Node2D

var throw_coal_scene: PackedScene = preload("res://scenes/projectiles/parabola_coal.tscn")
var death_scene: PackedScene = preload("res://scenes/temporary_deathscene.tscn")
var powerup_jump: PackedScene = preload("res://scenes/powerups/powerup_jump.tscn")
var right_side_zombies: PackedScene = preload("res://scenes/characters/zombi_child.tscn")
var left_side_zombies: PackedScene = preload("res://scenes/characters/leftsidezombie.tscn")
var missile_fragment: PackedScene = preload("res://scenes/projectiles/collectable_fragment_missile.tscn")

var did_santa_die: bool = false
const coal_speed: int = 300
func _on_santa_throw(pos,direction):
	var pcoal = throw_coal_scene.instantiate() as RigidBody2D
	pcoal.position = pos
	pcoal.gravity_scale = 1
	pcoal.linear_velocity = Vector2(direction*(400+abs($Santa.velocity.x)),-200)
	$Projectiles.add_child(pcoal)
	
const level_length: int = 10000
const level_scale: int =  10
var zombie_rate = 2

func spawn_missile_parts():
	var n=1
	var f=7
	while n<=1.5*f:
		var missile_part = missile_fragment.instantiate() as Area2D
		missile_part.position = Vector2(randi_range(100,level_length),576)
		add_child(missile_part)
		n+=1

func _ready():
	#spawn_missile_parts()
	$ZOMBIES/Zombie_timer.wait_time=zombie_rate
	$ZOMBIES/Zombie_timer.start()

func _process(_delta):
	if did_santa_die==false:
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
	dead.position.x=$Santa.position.x
	$tempdeathscene.add_child(dead)
	did_santa_die=true
	#$Santa.

func _on_zombie_timer_timeout():
	#if did_santa_die==false:
	var right_zombie = right_side_zombies.instantiate() as CharacterBody2D
	var left_zombie = left_side_zombies.instantiate() as CharacterBody2D
	right_zombie.position.x = $Santa.position.x + 1000 + randi_range(-10,10)

	left_zombie.position.x = $Santa.position.x - 500 + randi_range(-10,10)

	$ZOMBIES.add_child(right_zombie)
	$ZOMBIES.add_child(left_zombie)
	$ZOMBIES/Zombie_timer.wait_time=zombie_rate
	$ZOMBIES/Zombie_timer.start()

extends Node2D

var throw_coal_scene: PackedScene = preload("res://scenes/projectiles/parabola_coal.tscn")
var death_scene: PackedScene = preload("res://scenes/temporary_deathscene.tscn")
var powerup_jump: PackedScene = preload("res://scenes/powerups/powerup_jump.tscn")
var right_side_zombies: PackedScene = preload("res://scenes/characters/zombi_child.tscn")
var left_side_zombies: PackedScene = preload("res://scenes/characters/leftsidezombie.tscn")
var missile_fragment: PackedScene = preload("res://scenes/projectiles/collectable_fragment_missile.tscn")

var did_santa_die: bool = false
var level_num: int = 1
var change_level: bool = false
var check_dead: bool = false
var cured: bool = false
const cured_zombie_rate: int = 2

func _on_santa_throw(pos,direction):
	const coal_speed: int = 215
	var pcoal = throw_coal_scene.instantiate() as RigidBody2D
	pcoal.position = pos
	pcoal.gravity_scale = 1
	pcoal.linear_velocity = Vector2(direction*(coal_speed+abs($Santa.velocity.x)),-200)
	$Projectiles.add_child(pcoal)
	
var level_length: int = 20000
var level_scale = level_length / 20
var zombie_rate = 2
var start = Vector2(38,596)

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
	if did_santa_die==false and cured==false:
		zombie_rate = (level_length / ($Santa.position.x**1.3)) #/ level_scale 
		#print(zombie_rate,"     ",$Santa.position.x)
	if did_santa_die==true:
		level_reset(start)
	if check_dead==true:
		var dead_scene = death_scene.instantiate() as Sprite2D
		$child_node.add_child(dead_scene)
		
	#did_santa_die=true
		dead_scene.position=$Santa.position

		if Input.is_key_pressed(KEY_Y):
			for i in $child_node.get_children():
				i.queue_free()
			for i in $ZOMBIES/new_zombies.get_children():
				i.queue_free()
			check_dead=false
			did_santa_die=true
			
	
		
	if change_level==true:
		start = Vector2(38,level_num*576)
		level_reset(start)
		change_level=false
		
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
	#get_viewport().canvas_transform = Transform2D.IDENTITY
	check_dead=true

func level_reset(start):
	
	if level_num==3:
		spawn_missile_parts()
	if level_num==5:
		cured=true
		zombie_rate = cured_zombie_rate
	
	did_santa_die=false
	$Santa.dead=false
	#$Santa.set_collision_layer_value(4,true)
	$Santa.collected_missile_fragments=0
	$Santa.position = start
	$ZOMBIES/Zombie_timer.wait_time=zombie_rate
	$ZOMBIES/Zombie_timer.start()

#func level_next():
	

func _on_zombie_timer_timeout():
	#if did_santa_die==false:
	var right_zombie = right_side_zombies.instantiate() as CharacterBody2D
	var left_zombie = left_side_zombies.instantiate() as CharacterBody2D
	right_zombie.position.x = $Santa.position.x + 500 + randi_range(-10,10)
	right_zombie.position.y = 500
	left_zombie.position.x = $Santa.position.x - 500 + randi_range(-10,10)
	right_zombie.position.y = 500
	$ZOMBIES/new_zombies.add_child(right_zombie)
	$ZOMBIES/new_zombies.add_child(left_zombie)
	print('new-zombie')
	$ZOMBIES/Zombie_timer.wait_time=zombie_rate
	$ZOMBIES/Zombie_timer.start()

func _on_the_end_1_level_done():
	#print('done')
	$Control.change_scene()

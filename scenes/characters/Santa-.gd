extends CharacterBody2D

@export var can_missile: bool = false
var throw_coal_scene: PackedScene = preload("res://scenes/projectiles/parabola_coal.tscn")
var powerup_protect_scene: PackedScene = preload("res://scenes/powerups/powerup_protect_zone.tscn")
var facing_right: int = 1

signal throw(pos,direction)
signal missile(pos,direction)
signal die
signal cant_reload

const Gravity = 25
var jumpspeed: int = 500

var horizspeed: int = 150
const deaccel = 25
const idk_how_long_for_powerups: int = 4
const needed_missile_fragments: int = 7
@export var collected_missile_fragments = 0

@export var dead: bool = false

var throw_speed = .35
var misisle_speed = .5
var reloaded: bool = true



func _ready():
	position = Vector2(38,596)
	

func _process(delta):
	$reload_throw_timer.wait_time = throw_speed
	$reload_missile_timer.wait_time = misisle_speed
	if collected_missile_fragments >= needed_missile_fragments:
		can_missile = true
	
	if Input.is_action_pressed("left") and dead==false:
		velocity.x = - horizspeed*delta*100
		#$Santaimg.
		facing_right = -1
	elif Input.is_action_pressed("right")and dead == false:
		velocity.x = horizspeed*delta*100
		facing_right = 1
	else:
		velocity.x = 0
	
	if Input.is_action_just_pressed("up")and dead==false:
		if is_on_floor():
			velocity.y = -jumpspeed
	velocity.y+=Gravity*50*delta
	#print_debug(velocity.y)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("coal") and can_missile==false and reloaded==true and facing_right==1:
		reloaded=false
		$reload_throw_timer.start()
		var coal_pos = $CoalStartPos/rightMarker
		throw.emit(coal_pos.global_position, facing_right)
		
	elif Input.is_action_just_pressed("coal") and can_missile==false and reloaded ==true and facing_right==-1:
		reloaded=false
		$reload_throw_timer.start()
		var coal_pos = $CoalStartPos/leftMarker
		throw.emit(coal_pos.global_position, facing_right)
	elif Input.is_action_just_pressed("coal") and can_missile==true and reloaded==true and facing_right==1:
		reloaded=false
		$reload_missile_timer.start()
		var coal_pos = $CoalStartPos/rightMarker
		missile.emit(coal_pos.global_position,facing_right)
	elif Input.is_action_just_pressed("coal") and can_missile==true and reloaded==true and facing_right==-1:
		reloaded=false
		$reload_missile_timer.start()
		var coal_pos = $CoalStartPos/leftMarker
		missile.emit(coal_pos.global_position,facing_right)
	elif Input.is_action_just_pressed("coal") and reloaded==false:
		cant_reload.emit()
		print('cant')

#func _on_area_2d_area_entered(_area):
	#print(area.name)
	#if area.name =="ZombiChild_Area2D":
	#print('dead')
	#$".".queue_free()
	#die.emit()

func _on_powerup_jump_powerup_jump_sig():
	jumpspeed = 800
	$jumppwruptimer.wait_time = idk_how_long_for_powerups
	$jumppwruptimer.start()

func _on_jumppwruptimer_timeout():
	jumpspeed = 500

func _on_powerup_speed_powerup_speed_sig():
	horizspeed = 250
	$speedtimer.wait_time = idk_how_long_for_powerups
	$speedtimer.start()

func _on_speedtimer_timeout():
	horizspeed = 150

func _on_collectable_fragment_missile_missile_fragment_collected():
	collected_missile_fragments += 1
	print(collected_missile_fragments)

func _on_santa_area_2d_body_entered(body):
	if body.is_in_group("Zombies") and dead==false:
		die.emit()
		dead = true
		#print('die')


func _on_reload_throw_timer_timeout():
	reloaded=true # Replace with function body.
func _on_reload_missile_timer_timeout():
	reloaded=true # Replace with function body.


func _on_powerup_reload_powerup_reload_sig():
	throw_speed = 0.01
	misisle_speed = 0.01
	$reload_pwrup_timer.wait_time = idk_how_long_for_powerups
	$reload_pwrup_timer.start()


func _on_reload_pwrup_timer_timeout():
	throw_speed = .35
	misisle_speed = .5


func _on_powerup_protect_powerup_protect_sig():
	var powerup_protect = powerup_protect_scene.instantiate() as Area2D
	$".".add_child(powerup_protect)
	$protect_powerup_timer.wait_time = idk_how_long_for_powerups
	$protect_powerup_timer.start()
	#"Santa/powerup_protect_zone"


func _on_protect_powerup_timer_timeout():
	$".".remove_child($powerup_protect_zone)

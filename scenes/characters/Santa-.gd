extends CharacterBody2D

var can_missile: bool = false
var throw_coal_scene: PackedScene = preload("res://scenes/projectiles/parabola_coal.tscn")
var facing_right: int = 1

signal throw(pos,direction)
signal missile(pos,direction)
signal die

const Gravity = 25
var jumpspeed: int = 500

var horizspeed: int = 150
const deaccel = 25
const idk_how_long_for_powerups: int = 4

func _ready():
	position = Vector2(38,596)

func _process(delta):

	if Input.is_action_pressed("left"):
		velocity.x = - horizspeed*delta*100
		#$Santaimg.
		facing_right = -1
	elif Input.is_action_pressed("right"):
		velocity.x = horizspeed*delta*100
		facing_right = 1
	else:
		velocity.x = 0
	
	if Input.is_action_just_pressed("up"):
		if is_on_floor():
			velocity.y = -jumpspeed
	velocity.y+=Gravity
	
	move_and_slide()
	
	if Input.is_action_just_pressed("coal") and can_missile==false and facing_right==1:
		var coal_pos = $CoalStartPos/rightMarker
		throw.emit(coal_pos.global_position, facing_right)
	elif Input.is_action_just_pressed("coal") and can_missile==false and facing_right==-1:
		var coal_pos = $CoalStartPos/leftMarker
		throw.emit(coal_pos.global_position, facing_right)
	elif Input.is_action_just_pressed("coal") and can_missile==true and facing_right==1:
		var coal_pos = $CoalStartPos/rightMarker
		missile.emit(coal_pos.global_position,facing_right)
	elif Input.is_action_just_pressed("coal") and can_missile==true and facing_right==-1:
		var coal_pos = $CoalStartPos/leftMarker
		missile.emit(coal_pos.global_position,facing_right)

func _on_area_2d_area_entered(area):
	#print(area.name)
	if area.name =="ZombiChild_Area2D":
		queue_free()
		die.emit()

func _on_powerup_jump_powerup_jump_sig():
	jumpspeed = 1000
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

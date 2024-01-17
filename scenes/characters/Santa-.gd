extends CharacterBody2D

var can_missile: bool = false
var throw_coal_scene: PackedScene = preload("res://scenes/projectiles/parabola_coal.tscn")
var facing_right: int = 1

signal throw(pos,direction)
signal missile(pos,direction)

const Gravity = 20
const jumpspeed = 700
const floor = Vector2(0,-1)
const horizspeed = 300
# Called when the node enters the scene tree for the first time.
func _ready():
	#pos = Vector2(38,596)
	position = Vector2(38,596)
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Input.is_action_pressed("left"):
		velocity.x -= horizspeed*delta
		facing_right = -1
	elif Input.is_action_pressed("right"):
		velocity.x += horizspeed*delta
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
		
	pass

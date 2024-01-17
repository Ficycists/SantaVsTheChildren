extends CharacterBody2D

var can_missile: bool = false
var throw_coal_scene: PackedScene = preload("res://scenes/projectiles/parabola_coal.tscn")

signal throw(pos)
signal missile(pos)

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
	elif Input.is_action_pressed("right"):
		velocity.x += horizspeed*delta
	else:
		velocity.x = 0
	
	if Input.is_action_just_pressed("up"):
		if is_on_floor():
			velocity.y = -jumpspeed
	velocity.y+=Gravity
	
	move_and_slide()
	
	if Input.is_action_just_pressed("coal") and can_missile==false:
		var coal_pos = $CoalStartPos/Marker2D
		throw.emit(coal_pos.global_position)
	elif Input.is_action_just_pressed("coal") and can_missile==true:
		missile.emit()
		#var pcoal = throw_coal_scene.instantiate()
		#add_child(pcoal)
		
	pass

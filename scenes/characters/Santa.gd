extends CharacterBody2D


#var velocity = Vector2.ZERO

const Gravity = 20
const jumpspeed = 700
const floor = Vector2(0,-1)
# Called when the node enters the scene tree for the first time.
func _ready():
	#pos = Vector2(38,596)
	position = Vector2(38,596)
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Input.is_action_pressed("left"):
		velocity.x -= 200*delta
	elif Input.is_action_pressed("right"):
		velocity.x += 200*delta
	else:
		velocity.x = 0
	
	
	if Input.is_action_just_pressed("up"):
		if is_on_floor():
			velocity.y = -jumpspeed
	velocity.y+=Gravity
	
	move_and_slide()
	
	
	#position += velocity*delta
	
		
	pass

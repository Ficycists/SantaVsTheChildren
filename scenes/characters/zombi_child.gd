extends CharacterBody2D

signal change_direction
var direction = -1
var jumpspeed: int = 400
var jump: bool = false
const SPEED = 100
const Gravity: int = 30
func _ready():
	position.y=596
func _process(_delta):
	velocity.x = direction * SPEED
	
	if jump==true and is_on_floor():
		velocity.y = -jumpspeed
		jump = false
	velocity.y+=Gravity
	
	move_and_slide()


		

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
#
#func _physics_process(delta):
#	if 
#		if is_on_floor():
#			velocity.y = -jumpspeed
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()


func _on_area_2d_area_entered(area):
	if area.name=="Area2Dcoal":
		queue_free() # Replace with function body.

func _on_zombi_horiz_area_body_entered(body):
	#print(body.name)
	if body.is_in_group("BRICKS"):
		#print('a')
		jump = true
		

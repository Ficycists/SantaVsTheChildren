extends CharacterBody2D


var direction = 1
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




func _on_leftsidezombiearea_area_entered(area):
	if area.name=="Area2Dcoal":
		queue_free() # Replace with function body.


func _on_left_zombie_area_body_entered(body):
	
	if body.is_in_group("BRICKS"):
		jump = true


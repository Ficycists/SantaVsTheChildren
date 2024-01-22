extends CharacterBody2D

signal change_direction

var jumpspeed: int = 400
var jump: bool = false
const SPEED = 100
const Gravity: int = 30
func _ready():
	position.y=200
func _process(delta):
	velocity.x = -1 * SPEED*delta*75
	
	if jump==true and is_on_floor():
		velocity.y = -jumpspeed
		jump = false
	velocity.y+=Gravity
	
	move_and_slide()

func _on_area_2d_area_entered(area):
	if area.name=="Area2Dcoal" or area.name=="powerup_protect_zone":
		queue_free() # Replace with function body.

func _on_zombi_horiz_area_body_entered(body):
	if body.is_in_group("BRICKS"):
		jump = true
		

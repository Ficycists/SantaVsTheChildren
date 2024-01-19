extends CharacterBody2D


var direction = Vector2(1,0)
const SPEED = 100

func _ready():
	position.y=596
	
func _process(delta):
	velocity = direction * SPEED
	move_and_slide()




func _on_leftsidezombiearea_area_entered(area):
	if area.name=="Area2Dcoal":
		queue_free() # Replace with function body.

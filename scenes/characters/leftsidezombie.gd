extends CharacterBody2D


var direction = Vector2(1,0)
const SPEED = 100

#func _ready():
	#position = 3

func _process(delta):
	velocity = direction * SPEED
	move_and_slide()

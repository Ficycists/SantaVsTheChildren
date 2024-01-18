extends RigidBody2D

const gravity = 20
const horizspeed = 200
#pos = 
# Called when the node enters the scene tree for the first time.
func _ready():
	#var linear_velocity = Vector2(350,-350)
	#position = Vector2(100,100)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#if Input.is_action_pressed("coal"):
		
	pass
	
#func throw(delta):
	


func _on_area_2_dcoal_area_entered(_body):
	queue_free()



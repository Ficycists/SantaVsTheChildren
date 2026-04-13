extends Node2D
var elapsed : float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsed += delta
	
	if (elapsed >= 6):
		$Control.change_scene("res://scenes/intro.tscn")
	pass
	
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_Z:
			$Control.change_scene("res://scenes/intro.tscn")

extends Node2D

@onready var ficycists = $Ficycists

# Called when the node enters the scene tree for the first time.
func _ready():
	ficycists.modulate.a = 0.1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed && event.keycode == KEY_Z:
			$Control.quitGame()

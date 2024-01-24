extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
	play()
	pass # Replace with function body.

func getplaybackpos() -> float:
	return get_playback_position()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

extends Node2D
var hideLogo = false
@onready var main_menu_audio_player = $MainMenuAudioPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !hideLogo:
		if main_menu_audio_player.get_playback_position() >= 4:
			hideLogo = true
			$Opening.queue_free()
			$Sprite2D/Sprite2D.startMove = true

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_Z:
			$Control.change_scene("res://scenes/test_scene_1.tscn")

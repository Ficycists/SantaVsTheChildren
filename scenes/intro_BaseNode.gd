extends Node2D
var hideLogo = false
var jamSplashVisible : bool = true
@onready var main_menu_audio_player = $MainMenuAudioPlayer
@onready var jam_logo_timer = $jamLogoTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	jam_logo_timer.start()
	pass # Replace with function body.

func hideJam():
	$JamSplash.queue_free()
	jamSplashVisible = false
	main_menu_audio_player.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if jamSplashVisible && jam_logo_timer.is_stopped():
		hideJam()
	if !hideLogo:
		if main_menu_audio_player.get_playback_position() >= 4:
			hideLogo = true
			$Opening.queue_free()
			$Sprite2D/Sprite2D.startMove = true

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_Z:
			$Control.change_scene("res://scenes/story_scene_0.tscn")

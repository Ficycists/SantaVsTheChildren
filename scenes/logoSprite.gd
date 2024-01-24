extends Node2D

var isNotCentered : bool = 1;
var foo = false;
var blinking : bool = false;
var blinkCounter : int = 0;

var startMove = false;

@onready var main_menu_audio_player = $"../../MainMenuAudioPlayer"
@onready var sprite_2d_2 = $Sprite2D2

func _ready():
	#test
	print_debug("ready")
	position.y = 125
	
func _process(delta):
	if(startMove):
		if(isNotCentered):
			if foo:
				position.y -= 1
			foo = !foo
			if position.y <= 0:
				isNotCentered = false
				sprite_2d_2.animation = "animation1"
	print_debug(position.y)
	
	

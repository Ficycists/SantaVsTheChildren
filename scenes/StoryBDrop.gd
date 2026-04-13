extends ColorRect

var active : bool

@onready var label = $Label
@onready var label_2 = $Label2

func _ready():
	active = false
	label_2.visible = false

# Called when the node enters the scene tree for the first time.
func pcess():
	if active:
		if !label_2.visible:
			label_2.visible = true
		else:
			active = false
			$"..".next_active = true
			visible = false
	


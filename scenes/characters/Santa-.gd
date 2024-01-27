extends CharacterBody2D

@export var can_missile: bool = false
var throw_coal_scene: PackedScene = preload("res://scenes/projectiles/parabola_coal.tscn")
var powerup_protect_scene: PackedScene = preload("res://scenes/powerups/powerup_protect_zone.tscn")
var polar_bear_dead: PackedScene = preload("res://scenes/polar_bear_death.tscn")
var facing_right: int = 1

@onready var audio_stream_player_2d_hurtsfx = $AudioStreamPlayer2D_HURTSFX
@onready var audio_stream_player_2d_coalsfx = $AudioStreamPlayer2D_COALSFX
@onready var audio_stream_player_2d_pickupsfx = $AudioStreamPlayer2D_PICKUPSFX

@onready var santaimg = $Santaimg
var flipped : bool = false

#@export var Camera_position: Vector2 = $Camera2D.position
signal throw(pos,direction)
signal missile(pos,direction)
signal die
signal cant_reload

var Gravity = 25
var jumpspeed: int = 500
var horizspeed: int = 150
var orig_horiz_speed: int = 150
@export var lives: int = 3
const deaccel = 25
var d = false

const jump_pwr_time: int = 7
var speed_pwr_time: int = 6
const reload_pwr_time: int = 8
var prot_pwr_time: int = 9

@export var needed_missile_fragments: int = 7
@export var collected_missile_fragments = 0
@export var deer = 0

@export var dead: bool = false

var throw_speed = .25
var misisle_speed = .35
const orig_throw_speed = .25
const orig_misisle_speed = .35
var reloaded: bool = true

#var texture_progress = TextureProgressBar.new()


func _ready():
	position = Vector2(38,596)
	%missile.visible=false
	santaimg.animation = "idle"
	$Camera2D/UI/ColorRect2.visible=false
	$Camera2D/UI/ColorRect3.visible=false
	
func _process(delta):
	
	$%ProgressBar.value = floor($".".position.x / 20000 * 10)*10
	#$TextureProgressBar.position.y = $".".position.y#-80
	#$TextureProgressBar.position.x = $".".position.x#-50
	$reload_throw_timer.wait_time = throw_speed
	$reload_missile_timer.wait_time = misisle_speed
	$Timer.wait_time=.5
	#print(position.x)
	if collected_missile_fragments >= needed_missile_fragments:
		can_missile = true
		%missile.visible=true
	if can_missile == true:
		%missile.visible=true
	if Input.is_action_pressed("left") and dead==false:
		velocity.x = - horizspeed*delta*100
		#$Santaimg.
		facing_right = -1
		if !flipped:
			flipped = true
		
	elif Input.is_action_pressed("right")and dead == false:
		velocity.x = horizspeed*delta*100
		facing_right = 1
		if flipped:
			flipped = false
	else:
		velocity.x = 0
	if flipped && !santaimg.flip_h:
		santaimg.flip_h = true;
		%missile.flip_h =true
		%missile.position=$CoalStartPos/leftMarker.position
	elif !flipped && santaimg.flip_h:
		santaimg.flip_h = false;
		%missile.flip_h=false
		%missile.position=$CoalStartPos/rightMarker.position
	if Input.is_action_just_pressed("up")and dead==false:
		if is_on_floor():
			velocity.y = -jumpspeed
	#print_debug(velocity.y)
	
	if Input.is_action_just_pressed("Down") and dead == false:
		if !is_on_floor() and d==false:
			d = true
			$Timer.start()
			Gravity = 100
			
	velocity.y+=Gravity*50*delta
	
	if int(velocity.x) != 0 and is_on_floor():
		santaimg.animation = "run"
	elif !is_on_floor():
		santaimg.animation = "jump"
	else:
		santaimg.animation = "idle"
	
	move_and_slide()
	
	if Input.is_action_just_pressed("coal") and can_missile==false and reloaded==true and facing_right==1:
		reloaded=false
		$reload_throw_timer.start()
		var coal_pos = $CoalStartPos/rightMarker
		throw.emit(coal_pos.global_position, facing_right)
		audio_stream_player_2d_coalsfx.play()
		
	elif Input.is_action_just_pressed("coal") and can_missile==false and reloaded ==true and facing_right==-1:
		reloaded=false
		$reload_throw_timer.start()
		var coal_pos = $CoalStartPos/leftMarker
		throw.emit(coal_pos.global_position, facing_right)
	elif Input.is_action_just_pressed("coal") and can_missile==true and reloaded==true and facing_right==1:
		reloaded=false
		$reload_missile_timer.start()
		var coal_pos = $CoalStartPos/rightMarker
		missile.emit(coal_pos.global_position,facing_right)
	elif Input.is_action_just_pressed("coal") and can_missile==true and reloaded==true and facing_right==-1:
		reloaded=false
		$reload_missile_timer.start()
		var coal_pos = $CoalStartPos/leftMarker
		missile.emit(coal_pos.global_position,facing_right)
	elif Input.is_action_just_pressed("coal") and reloaded==false:
		cant_reload.emit()
	
	%jump_label.text = str(round($jumppwruptimer.time_left))
	#%jump_label.position = $UI/HBoxContainer/jump_power_indicator.position
	%speed_label.text = str(round($speedtimer.time_left))
	#%speed_label.position = $UI/HBoxContainer/speed_power_indicator.position
	%reload_label.text = str(round($reload_pwrup_timer.time_left))
	#%reload_label.position = $UI/HBoxContainer/reload_power_indicator.position
	%prot_label.text = str(round($protect_powerup_timer.time_left))
	#%prot_label.position = $UI/HBoxContainer/protect_power_indicator.position

func _on_reload_throw_timer_timeout():
	reloaded=true 
func _on_reload_missile_timer_timeout():
	reloaded=true

func _on_collectable_fragment_missile_missile_fragment_collected():
	audio_stream_player_2d_pickupsfx.play()
	collected_missile_fragments += 1
	if lives < 5:
		lives += 1
		$Camera2D/UI/ColorRect3.visible=true
		$Camera2D/UI/deadtimer.start()
	$Control/RichTextLabel.text = str(lives) + " lives"
	#print(collected_missile_fragments)

var counter_attacks = 0
func _on_santa_area_2d_body_entered(body):
	if body.is_in_group("Zombies") and dead==false:
		audio_stream_player_2d_hurtsfx.play()
		if lives <= 0:
			die.emit()
			dead = true
		lives -= 1
		$Camera2D/UI/ColorRect2.visible=true
		$Camera2D/UI/deadtimer.start()
		$Control/RichTextLabel.text = str(lives) + " lives"

func _on_powerup_jump_powerup_jump_sig():
	jumpspeed = 800
	$jumppwruptimer.wait_time = jump_pwr_time
	$jumppwruptimer.start()
	$Camera2D/UI/HBoxContainer/jump_power_indicator.visible=true
	%jump_label.visible=true
func _on_jumppwruptimer_timeout():
	jumpspeed = 500
	$Camera2D/UI/HBoxContainer/jump_power_indicator.visible=false
	%jump_label.visible=false
func _on_powerup_speed_powerup_speed_sig():
	horizspeed = 250
	$speedtimer.wait_time = speed_pwr_time
	$speedtimer.start()
	$Camera2D/UI/HBoxContainer/speed_power_indicator.visible=true
	%speed_label.visible=true

func _on_speedtimer_timeout():
	horizspeed = orig_horiz_speed
	$Camera2D/UI/HBoxContainer/speed_power_indicator.visible=false
	%speed_label.visible=false

func _on_powerup_reload_powerup_reload_sig():
	throw_speed = 0.01
	misisle_speed = 0.01
	$reload_pwrup_timer.wait_time = reload_pwr_time
	$reload_pwrup_timer.start()
	$Camera2D/UI/HBoxContainer/reload_power_indicator.visible=true
	%reload_label.visible=true
func _on_reload_pwrup_timer_timeout():
	throw_speed = orig_throw_speed
	misisle_speed = orig_misisle_speed
	$Camera2D/UI/HBoxContainer/reload_power_indicator.visible=false
	%reload_label.visible=false
func _on_powerup_protect_powerup_protect_sig():
	var powerup_protect = powerup_protect_scene.instantiate() as Area2D
	$".".add_child(powerup_protect)	
	$Camera2D/UI/HBoxContainer/protect_power_indicator.visible=true
	%prot_label.visible=true
	$protect_powerup_timer.wait_time = prot_pwr_time
	$protect_powerup_timer.start()

func _on_protect_powerup_timer_timeout():
	$".".remove_child($powerup_protect_zone)
	$Camera2D/UI/HBoxContainer/protect_power_indicator.visible=false
	%prot_label.visible=false
func _on_timer_timeout():
	d=false
	Gravity =25
	$Timer.start() # Replace with function body.


func _on_santa_area_2d_area_entered(area):
	if "polar bear" in area.name:
		var polar_bear_death = polar_bear_dead.instantiate() as Sprite2D
		$".".add_child(polar_bear_death)
		$"POLAR BEAR".start()
		


func _on_powerup_jump_2_powerup_jump_sig():
	pass # Replace with function body.


func _on_deer_missile_fragment_collected():
	audio_stream_player_2d_pickupsfx.play()
	deer +=1
	if lives < 3:
		lives += 1
		$Camera2D/UI/ColorRect3.visible=true
		$Camera2D/UI/deadtimer.start()
	$Control/RichTextLabel.text = str(lives) + " lives"
	orig_horiz_speed=150*(1+(deer/10))
	#print(deer) # Replace with function body.


func _on_polar_bear_timeout():
	die.emit()
	dead=true


func _on_deadtimer_timeout():
	$Camera2D/UI/ColorRect2.visible=false
	$Camera2D/UI/ColorRect3.visible=false

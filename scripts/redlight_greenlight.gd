extends Node2D

var is_red_light = false
@export var red_duration = 2.0
@export var green_duration = 3.0
var player_ref
var screen_tint
var is_active = false
var red_light = preload("res://assets/audio/red_light_muffed.wav")
var green_light = preload("res://assets/audio/geen_light_muffed.wav")
var get_ready = preload("res://assets/audio/get_ready_robot.wav")
@onready var announcer: AudioStreamPlayer2D = $announcer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.timeout.connect(_on_timer_timeout)
	set_process(false)
	visible = false     
	player_ref = get_tree().get_first_node_in_group("player")
	screen_tint = get_tree().get_first_node_in_group("screen_tint")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_red_light and player_ref != null:
		var velocity = player_ref.get("velocity") if player_ref.has_method("get_velocity") else Vector2.ZERO
		if velocity.length() > 5:
			_on_player_moved_during_red()
func _on_timer_timeout():
	is_red_light = !is_red_light
	if is_red_light:
		_start_red()
	else:
		_start_green()

func _start_green():
	announcer.stream = green_light
	announcer.play()
	await get_tree().create_timer(0.5).timeout
	is_red_light = false
	$Timer.start(green_duration)
	_set_tint(Color(0, 1, 0, 0.15))

func _start_red():
	announcer.stream = red_light
	announcer.play()
	await get_tree().create_timer(0.5).timeout
	is_red_light = true
	$Timer.start(red_duration)
	_set_tint(Color(1, 0, 0, 0.15))

func _on_player_moved_during_red():
	player_ref.die() 
	

func activate_anomaly():
	is_active = true
	announcer.stream = get_ready
	announcer.play()
	visible = true
	set_process(true)
	await get_tree().create_timer(3.0).timeout
	_start_green()
	#$Timer.start()
func _set_tint(color: Color):
	if screen_tint:
		print("runs")
		screen_tint.color = color

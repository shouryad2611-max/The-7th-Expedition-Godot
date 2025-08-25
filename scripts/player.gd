extends CharacterBody2D

@onready var player_animations: AnimatedSprite2D = $player_animations
@export var walk_speed = 150.0
@export_range(0,1) var deceleration = 0.1
@export_range(0,1) var acceleration = 0.1
var is_jumping = false
var JUMP_VELOCITY = -250
@onready var interact_ui: CanvasLayer = $interact_ui
@onready var footsteps: AudioStreamPlayer2D = $footsteps
var time_since_last_step = 0.0
var step_interval = 0.4
var is_dead = false


func _physics_process(delta: float) -> void:
	if is_dead:
		return
	time_since_last_step += delta
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		is_jumping = true
		velocity.y = JUMP_VELOCITY
	else:
		is_jumping = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction > 0:
		player_animations.flip_h = false
	if direction < 0:
		player_animations.flip_h = true
	if direction == 0:
		player_animations.play("idle")
	if direction:
		player_animations.play("run")
		velocity.x = move_toward(velocity.x,direction * walk_speed,walk_speed*acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed*deceleration)
	
	var is_moving = abs(velocity.x) > 50
	
	if is_moving and is_on_floor() and time_since_last_step >= step_interval:
		play_footsteps()
		time_since_last_step = 0.0
	move_and_slide()

func player():
	pass

func play_footsteps():
	if not footsteps.playing:
		footsteps.play()

func die():
	is_dead = true
	player_animations.play("death")
	AnomalyManager.progress_count = 0
	await get_tree().create_timer(0.8).timeout
	get_tree().reload_current_scene()

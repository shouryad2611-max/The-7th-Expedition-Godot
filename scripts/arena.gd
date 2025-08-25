extends Node2D

@onready var progress_bar: TextureProgressBar = $progress_bar

var player_in_range = false
var is_forward = true
var hover = preload("res://assets/audio/hover-button.mp3")
var click = preload("res://assets/audio/computer-mouse-click.mp3")

var is_paused = false
func _ready() -> void:
	$fade/AnimationPlayer.play("fade_out")
	AnomalyManager.is_active = false
	AnomalyManager.assign_anomaly()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		$fade/AnimationPlayer.play("fade_in")
		await $fade/AnimationPlayer.animation_finished
		AnomalyManager.handle_interactions(is_forward)
	progress_bar.value = AnomalyManager.progress_count
	


func _on_forward_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		is_forward = true
		player_in_range = true
		body.interact_ui.visible = true
		


func _on_forward_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = false
		body.interact_ui.visible = false


func _on_backward_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		is_forward = false
		player_in_range = true
		body.interact_ui.visible = true


func _on_backward_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = false
		body.interact_ui.visible = false
"""func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()

func _on_resume_pressed() -> void:
	play_audio(click)
	await get_tree().create_timer(0.2).timeout
	toggle_pause()


func _on_resume_mouse_entered() -> void:
	play_audio(hover)


func _on_main_menu_pressed() -> void:
	play_audio(click)
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_main_menu_mouse_entered() -> void:
	play_audio(hover)

func toggle_pause():
	is_paused = !is_paused
	get_tree().paused = is_paused
	if get_tree().paused:
		print("works")
	pause_menu.visible = is_paused
	print(pause_menu)

func play_audio(audio: AudioStream):
	button_audio.stream = audio
	button_audio.play()"""

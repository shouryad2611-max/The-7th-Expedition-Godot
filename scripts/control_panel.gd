extends Area2D

var is_active = false
var player_in_range = false
@onready var audio: AudioStreamPlayer2D = $audio
var good_audio = preload("res://assets/audio/muffled_audio.wav")
var bad_audio = preload("res://assets/audio/anomaly_audio.wav")
func activate_anomaly():
	is_active = true

func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		$animations.play("deactivate")
		if is_active:
			audio.stream = bad_audio
		else:
			audio.stream = good_audio
		audio.play()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = true
		body.interact_ui.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = false
		body.interact_ui.visible = false

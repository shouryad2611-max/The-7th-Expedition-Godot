extends Control

var hover = preload("res://assets/audio/hover-button.mp3")
var click = preload("res://assets/audio/computer-mouse-click.mp3")
@onready var button_audio: AudioStreamPlayer2D = $button_audio
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$engine.play()
	$fade/fade_rect/AnimationPlayer.play("fade_out")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	play_audio(click)
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_button_mouse_entered() -> void:
	play_audio(hover)

func play_audio(audio: AudioStream):
	button_audio.stream = audio
	button_audio.play()

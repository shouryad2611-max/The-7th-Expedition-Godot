extends CanvasLayer

@onready var pause_menu: CanvasLayer = $"."

var hover = preload("res://assets/audio/hover-button.mp3")
var click = preload("res://assets/audio/computer-mouse-click.mp3")
@onready var button_audio: AudioStreamPlayer2D = $button_audio
var is_paused = false
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	pass

func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()

func _on_resume_pressed() -> void:
	print("working")
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
	button_audio.play()

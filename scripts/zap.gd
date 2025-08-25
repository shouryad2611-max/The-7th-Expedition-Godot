extends Area2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

var time_to_next_emit := 0.0

func _ready() -> void:
	reset_timer()

func _process(delta: float) -> void:
	time_to_next_emit -= delta
	if time_to_next_emit <= 0:
		emit_zap()
		reset_timer()

func reset_timer():
	time_to_next_emit = randf_range(5, 15)

func emit_zap():
	animated_sprite.play("zap")
	audio.play()

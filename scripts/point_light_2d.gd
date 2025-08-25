extends PointLight2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var t = Time.get_ticks_msec() / 200.0
	energy = sin(t) * 0.5 + 1.0

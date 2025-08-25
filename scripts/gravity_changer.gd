extends Node2D

var is_active = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activate_anomaly():
	is_active = true
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.JUMP_VELOCITY = -400
		

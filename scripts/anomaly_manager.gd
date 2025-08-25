extends Node

var progress_count = 0
const required_progress = 7
var is_active = false
@export_range(0,100) var chance_of_anomaly = 50.0

func _process(delta: float) -> void:
	pass
func _ready() -> void:
	randomize()

func assign_anomaly():
	var all_anomalies = get_tree().get_nodes_in_group("anomaly")
	print(all_anomalies)
	
	if randi() % 100 < chance_of_anomaly and all_anomalies.size() > 0:
		print("choosing")
		var chosen = all_anomalies.pick_random()
		print(chosen)
		if chosen.has_method("activate_anomaly"):
			chosen.is_active = true
			chosen.activate_anomaly()
			is_active = true
	else:
		false

"""func has_active_anomalies():
	for anomaly in get_tree().get_nodes_in_group("anomaly"):
		if anomaly.has_variable("is_active") and anomaly.is_active:
			return true
	return false"""

func handle_interactions(is_forward: bool):
	
	if (is_forward and is_active) or (not is_forward and not is_active):
		progress_count += 1
		print(" Correct! Progress:", progress_count)
		if progress_count >= required_progress:
			game_won()
		else:
			await reload_scene()
	else:
		progress_count = 0
		print("Wrong , restarting")
		await reload_scene()

func reload_scene():
	await get_tree().create_timer(0.3).timeout
	get_tree().reload_current_scene()

func game_won():
	print("game_Won")
	get_tree().change_scene_to_file("res://scenes/victory_scene.tscn")

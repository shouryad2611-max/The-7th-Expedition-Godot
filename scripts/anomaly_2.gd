extends Area2D

var is_active = false

func activate_anomaly():
	is_active = true
	$AnimatedSprite2D.play("firing_turret")

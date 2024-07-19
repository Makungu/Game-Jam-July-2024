extends Control

signal health_changed(health)
signal initialise_health(max_health)
signal light_changed(light)
signal initialise_light(max_light)


func _on_player_health_changed(health):
	emit_signal("health_changed", health)

func _on_player_initialise_health(max_health):
	emit_signal("initialise_health", max_health)

func _on_player_initialise_light(max_light):
	emit_signal("initialise_light", max_light)

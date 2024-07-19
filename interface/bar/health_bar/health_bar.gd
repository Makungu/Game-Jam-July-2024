extends HBoxContainer

func _on_interface_health_changed(health):
	$TextureProgressBar.value = health

func _on_interface_initialise_health(max_health):
	$TextureProgressBar.max_value = max_health
	$TextureProgressBar.value = max_health

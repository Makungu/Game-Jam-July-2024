extends HBoxContainer

func _on_interface_light_changed(light):
	$TextureProgressBar.value = light

func _on_interface_initialise_light(max_light):
	$TextureProgressBar.max_value = max_light
	$TextureProgressBar.value = max_light

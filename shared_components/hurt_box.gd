class_name HurtBox
extends Area2D

func _on_area_entered(area):
	if owner.has_method("take_damage"):
		owner.take_damage(area.damage)

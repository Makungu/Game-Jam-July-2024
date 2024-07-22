class_name HitBox
extends Area2D

@export var damage: int
@export var target_group: String

func _on_body_entered(body):
	if body.is_in_group(target_group) && body.has_method("take_damage"):
		body.take_damage(damage)

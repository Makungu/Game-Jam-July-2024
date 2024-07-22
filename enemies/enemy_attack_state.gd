class_name EnemyAttackState
extends State

@export var idle_state: EnemyIdleState 
@export var chase_state: EnemyChaseState

var hit_box_instance: Node

func on_enter():
	enemy.animation_tree.set("parameters/conditions/is_attacking", true)
	enemy.animation_tree.set("parameters/Attack/blend_position", enemy.direction)
	attack()
	
func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "Attack_Down" || anim_name == "Attack_Up" || anim_name == "Attack_Side":
		hit_box_instance.queue_free()
		if enemy.position.distance_to(player.position) < 100:
			next_state = chase_state
		else:	
			next_state = idle_state
		
func attack():
	hit_box_instance = enemy.hit_box.instantiate()
	var position = enemy.position
	if enemy.direction.x != 0:
		position.x += 10 if enemy.direction.x > 0 else -10
	if enemy.direction.y != 0:
		position.y += 10 if enemy.direction.y > 0 else -10 
	hit_box_instance.position = position
	hit_box_instance.damage = 50
	hit_box_instance.target_group = "player"
	add_child(hit_box_instance)
	
func on_exit():
	enemy.animation_tree.set("parameters/conditions/is_attacking", false)


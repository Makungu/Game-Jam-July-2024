class_name EnemyChaseState
extends State

@export var idle_state: EnemyIdleState 
@export var attack_state: EnemyAttackState 

var wander_time: float = 0.0

func on_enter():
	enemy.animation_tree.set("parameters/conditions/is_moving", true)
	enemy.animation_tree.set("parameters/Run/blend_position", enemy.direction)
	
func state_process(delta):
	if enemy.position.distance_to(player.position) > 100:
		next_state = idle_state
	elif enemy.position.distance_to(player.position) < 30:
		next_state = attack_state
	else:
		enemy.direction = enemy.position.direction_to(player.position).normalized()
		enemy.animation_tree.set("parameters/Run/blend_position", enemy.direction)
		enemy.velocity = enemy.direction * enemy.speed

func on_exit():
	enemy.animation_tree.set("parameters/conditions/is_moving", false)

class_name EnemyIdleState
extends State

@export var chase_state: EnemyChaseState 

var wander_time: float = 0.0

func on_enter():
	randomise_wander()
	enemy.animation_tree.set("parameters/conditions/is_moving", true)
	enemy.animation_tree.set("parameters/Run/blend_position", enemy.direction)
	
func state_process(delta):
	if enemy.position.distance_to(player.position) < 100:
		next_state = chase_state
	else:
		if wander_time > 0:
			wander_time -= delta
		else:	
			randomise_wander()
		enemy.velocity = enemy.direction * enemy.speed
	
func randomise_wander():
	enemy.direction = Vector2(randf_range(-1, 1), randf_range(-1.1, 1.1))
	enemy.animation_tree.set("parameters/conditions/is_moving", true)
	enemy.animation_tree.set("parameters/Run/blend_position", enemy.direction)
	wander_time = randf_range(1, 3)
	
func on_exit():
	enemy.animation_tree.set("parameters/conditions/is_moving", false)

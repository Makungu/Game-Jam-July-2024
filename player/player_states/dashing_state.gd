class_name DashState
extends State

@export var idle_state: IdleState
@export var run_state: RunState
@export var attack_state: AttackState


func on_enter():
	#player.animation_tree.set("parameters/conditions/is_moving", true)
	#player.animation_tree.set("parameters/Run/blend_position", player.direction)
	player.velocity += player.direction * player.max_accelaration * 50
	for child in player.get_children():
		if child is HurtBox: 
			child.process_mode = Node.PROCESS_MODE_DISABLED
	#play dashing animation here and set player to invuln
	#player.animation_tree.set("parameters/Run/blend_position", player.direction)


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "dodge_down" || anim_name == "dodge_up" || anim_name == "dodge_left_right":
		for child in player.get_children():
			if child is HurtBox: 
				child.process_mode = Node.PROCESS_MODE_INHERIT
				
		var direction = Input.get_vector("move_left","move_right","move_up","move_down")
		if direction != Vector2.ZERO:
			next_state = run_state
		elif Input.is_action_pressed("melee_attack"):
			next_state = attack_state
		else:
			next_state = idle_state
			

func on_exit():
	pass
	#player.animation_tree.set("parameters/conditions/is_moving", false)


class_name DodgeState
extends State

@export var idle_state: IdleState
@export var run_state: RunState
@export var attack_state: AttackState


func on_enter():
	player.animation_tree.set("parameters/conditions/is_dodging", true)
	player.animation_tree.set("parameters/Run/blend_position", player.direction)
	# 0.4 is arbitrary dampening of velocity to make the roll not go as far
	player.velocity += player.direction * player.accelaration * 0.4
	for child in player.get_children():
		if child is HurtBox: 
			child.process_mode = Node.PROCESS_MODE_DISABLED


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "Roll_Down" || anim_name == "Roll_Up" || anim_name == "Roll_Side":
		for child in player.get_children():
			if child is HurtBox: 
				child.process_mode = Node.PROCESS_MODE_INHERIT
		
		player.velocity = Vector2.ZERO		
		var direction = Input.get_vector("move_left","move_right","move_up","move_down")
		if direction != Vector2.ZERO:
			next_state = run_state
		elif Input.is_action_pressed("melee_attack"):
			next_state = attack_state
		else:
			next_state = idle_state
			

func on_exit():
	player.animation_tree.set("parameters/conditions/is_dodging", false)


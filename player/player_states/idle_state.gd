class_name IdleState
extends State

@export var dash_state: DashState
@export var run_state: RunState
@export var attack_state: AttackState

func on_enter():
	player.animation_tree.set("parameters/conditions/is_idle", true)
	player.animation_tree.set("parameters/Idle/blend_position", player.direction)

func state_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	if direction != Vector2.ZERO:
		next_state = run_state
		
func state_input(event: InputEvent):
	if event.is_action_pressed("dash"):
		next_state = dash_state
	if event.is_action_pressed("melee_attack"):
		next_state = attack_state
		
func on_exit():
	player.animation_tree.set("parameters/conditions/is_idle", false)

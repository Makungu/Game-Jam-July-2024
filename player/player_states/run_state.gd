class_name RunState
extends State

@export var dash_state: DashState
@export var idle_state: IdleState
@export var attack_state: AttackState

func on_enter():
	player.animation_tree.set("parameters/conditions/is_moving", true)
	player.animation_tree.set("parameters/Run/blend_position", player.direction)

func state_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	player.direction = direction if direction != Vector2.ZERO else player.direction
	if direction == Vector2.ZERO:
		player.velocity = Vector2.ZERO
		next_state = idle_state
	else:
		player.animation_tree.set("parameters/Run/blend_position", player.direction)
		player.velocity += player.direction * player.max_accelaration * delta 
		player.velocity.limit_length(player.max_speed)
		if player.direction.x < 0:
			player.sprite.flip_h = true
		elif player.direction.x > 0:
			player.sprite.flip_h = false
	
func state_input(event: InputEvent):
	if event.is_action_pressed("dash"):
		next_state = dash_state
	elif event.is_action_pressed("melee_attack"):
		next_state = attack_state

func on_exit():
	player.animation_tree.set("parameters/conditions/is_moving", false)

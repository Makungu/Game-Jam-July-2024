class_name AttackState
extends State

@export var dash_state: DashState
@export var run_state: RunState
@export var idle_state: IdleState

var hit_box_instance: Node

@onready var timer: Timer = $Timer

func on_enter():
	timer.wait_time = 0.8
	timer.start()
	player.animation_tree.set("parameters/conditions/is_attacking", true)
	player.animation_tree.set("parameters/Attack/blend_position", player.direction)
	attack()
	
func state_input(event: InputEvent): 
	# lock player out of next attack if first anim is not complete
	if event.is_action_pressed("melee_attack"):
		timer.start()
		attack()

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "attack_down" || anim_name == "attack_up" || anim_name == "attack_left_right":
		if timer.is_stopped():
			hit_box_instance.queue_free()
			# check for inputs here, might need to transition to run or dash from this state
			next_state = idle_state
		else:
			# play next attack in the sequence here
			pass
	
	
func attack():
	hit_box_instance = player.hit_box.instantiate()
	var position = player.position
	if player.direction.x != 0:
		position.x += 10 if player.direction.x > 0 else -10
	if player.direction.y != 0:
		position.y += 10 if player.direction.y > 0 else -10 
	hit_box_instance.position = position
	hit_box_instance.damage = 50
	add_child(hit_box_instance)
	
func on_exit():
	player.animation_tree.set("parameters/conditions/is_attacking", false)

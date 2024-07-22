class_name EnemyStateMachine
extends Node

@export var enemy: Enemy
@export var current_state: State

var states: Array[State]

func _ready():
	for child in get_children():
		if child is State:
			child.enemy = enemy
			child.player = get_tree().get_first_node_in_group("player")
			states.append(child)
		else:
			push_warning(child.name + " is not a valid state for the player state machine")

func _physics_process(delta):
	if current_state.next_state != null:
		change_state(current_state.next_state)
	
	if enemy.health > 0:
		current_state.state_process(delta)
	
	
func _input(event: InputEvent):
	if enemy.health > 0:
		current_state.state_input(event)

func change_state(new_state: State):
	current_state.on_exit()
	current_state = new_state
	current_state.next_state = null
	current_state.on_enter()
	

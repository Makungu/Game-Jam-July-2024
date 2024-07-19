class_name State
extends Node

var player: Player
var next_state: State

# Any setup that should be done when entering the current state should be done here .
func on_enter():
	pass

# Any tear down that should be done when exiting the current state should be done here.
func on_exit():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	pass
	
# Inputs called in the current state.
func state_input(event: InputEvent):
	pass

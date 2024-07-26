class_name State
extends Node

@export var _stateMachine : State_Machine 
# We store a reference to the state machine to call its `transition_to()` method directly.


# All methods below are virtual and called by the state machine.
func HandleIinput(_event: InputEvent) -> void:
	pass


# Corresponds to the `_process()` callback.
func Update(_delta: float) -> void:
	pass


# Corresponds to the `_physics_process()` callback.
func PhysicsUpdate(_delta: float) -> void:
	pass


# Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func Enter(_msg := {}) -> void:
	pass


# Called by the state machine before changing the active state. Use this function
# to clean up the state.
func Exit() -> void:
	pass

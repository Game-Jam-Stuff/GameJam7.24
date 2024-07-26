class_name State_Machine
extends Node


# Emitted when transitioning to a new state.
signal transitioned(state_name)

@export var initial_state := NodePath()

@onready var state: State = get_node(initial_state)

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("InitializeStateMachine")


func  InitializeStateMachine():
	var initial_state_node = get_node(initial_state)
	if initial_state_node is State:
		state = initial_state_node
	else:
		printerr("Initial state node is not of type State.")
		return
	print(self)
	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		if child is State:
			print(child)
			child._stateMachine = self

	state.Enter()

func _process(delta: float) -> void:
	state.Update(delta)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	state.PhysicsUpdate(delta)
	

func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		return

	state.Exit()
	state = get_node(target_state_name)
	state.Enter(msg)
	emit_signal("transitioned", state.name)

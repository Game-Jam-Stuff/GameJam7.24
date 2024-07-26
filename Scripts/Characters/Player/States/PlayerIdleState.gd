class_name PlayerIdleState
extends PlayerState


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Idle Ready")
	super._ready()

# Called Every Time State is entered
func Enter(_msg := {}) -> void:
	print("Idle Enter");
	_character.stateLabel.text = "IdleState"
	_character._animations.play(GameContants.PlayerAnimations.ANIM_IDLE)


	
func PhysicsUpdate(delta: float) -> void:
	super.PhysicsUpdate(delta)
	handleStateChange(delta)
	
	
func handleStateChange(delta):
	match _character.movementType:
		_character.movementTypes.SIDE:
			if Input.is_action_just_pressed(GameContants.UserInputs.JUMP):
				_stateMachine.transition_to(GameContants.PlayerStates.JUMP, {do_jump = true, _delta = delta})
			elif !_character.is_on_floor():
				_stateMachine.transition_to(GameContants.PlayerStates.JUMP, {do_jump = false, _delta = delta})
			elif Input.is_action_just_pressed(GameContants.UserInputs.DASH) and _character.can_dash:
				_stateMachine.transition_to(GameContants.PlayerStates.DASH)
			elif Input.is_action_just_pressed(GameContants.UserInputs.CROUCH):
				_stateMachine.transition_to(GameContants.PlayerStates.CROUCH)

	
	if (Input.is_action_just_pressed(GameContants.UserInputs.MOVE_RIGHT) || Input.is_action_just_pressed(GameContants.UserInputs.MOVE_LEFT)
	|| Input.is_action_just_pressed(GameContants.UserInputs.MOVE_UP) || Input.is_action_just_pressed(GameContants.UserInputs.MOVE_DOWN)):
		_stateMachine.transition_to(GameContants.PlayerStates.MOVE)
		

func Update(_delta: float) -> void:
	pass

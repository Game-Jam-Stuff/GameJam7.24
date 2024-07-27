class_name PlayerMoveState
extends PlayerState


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Move Ready")
	super._ready()
	

# Called Every Time State is entered
func Enter(_msg := {}) -> void:
	print("Move Enter");
	_character.stateLabel.text = "MoveState"
	if _character.hurtTimer.is_stopped():
		_character._animations.play(GameContants.PlayerAnimations.ANIM_MOVING)

func Update(_delta):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func PhysicsUpdate(delta):
	

	getDirection()
	move(delta)
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
			
	if _character.velocity == Vector2.ZERO:
		_stateMachine.transition_to(GameContants.PlayerStates.IDLE)

func move(delta):
	match _character.movementType:
		_character.movementTypes.SIDE:
			handleSideMovement(delta)
		_character.movementTypes.TOPDOWN:
			handleTopDownMovement(delta)


func handleSideMovement(delta):
	if _character.direction.x != 0:
		# This functions allow for changes in speed, so a more realistic acceleration.
		_character.velocity.x = move_toward(_character.velocity.x,  _character.direction.x * _character.run_speed, _character.acceleration * delta)
	else:
		# If we are stopping, let's slow down and gradually come to a stop. It's more realistic and fluid.
		_character.velocity.x = move_toward(_character.velocity.x, 0, _character.friction * delta)
	
	

func handleTopDownMovement(delta):
	if _character.direction != Vector2.ZERO:
		# This functions allow for changes in speed, so a more realistic acceleration.
		_character.velocity = _character.velocity.move_toward(_character.direction * _character.run_speed, _character.acceleration * delta)
	else:
		# If we are stopping, let's slow down and gradually come to a stop. It's more realistic and fluid.
		_character.velocity = _character.velocity.move_toward(Vector2.ZERO, _character.friction * delta)



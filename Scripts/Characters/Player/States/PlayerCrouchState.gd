class_name PlayerCrouchState
extends PlayerState


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Crouch Ready")
	super._ready()

# Called Every Time State is entered
func Enter(_msg := {}) -> void:
	print("Crouch Enter");
	_character.stateLabel.text = "CrouchState"
	#_character._animations.play("Crouch")
	

func Exit(_msg := {}) -> void:
	pass

func PhysicsUpdate(_delta: float) -> void:
	getDirection()
	handleCrouchMovement(_delta)
	handleStateChange(_delta)
	super.PhysicsUpdate(_delta)
	

func Update(_delta: float) -> void:
	pass

func crouchDown():
	pass
	
func handleCrouchMovement(delta):
	if _character.direction.x != 0:
		# This functions allow for changes in speed, so a more realistic acceleration.
		_character.velocity.x = move_toward(_character.velocity.x,  _character.direction.x * _character.run_speed * _character.crouchMultiplier, (_character.acceleration * _character.crouchMultiplier) * delta)
	else:
		# If we are stopping, let's slow down and gradually come to a stop. It's more realistic and fluid.
		_character.velocity.x = move_toward(_character.velocity.x, 0, _character.friction * delta)

func handleStateChange(delta):
	if Input.is_action_just_pressed(GameContants.UserInputs.CROUCH):
		_stateMachine.transition_to(GameContants.PlayerStates.IDLE)
	elif !_character.is_on_floor():
		_stateMachine.transition_to(GameContants.PlayerStates.JUMP, {do_jump = false, _delta = delta})


func _on_animation_tree_animation_finished(anim_name):
	pass # Replace with function body.

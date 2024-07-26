class_name PlayerState
extends CharacterState


# These are the movement functions. Multiple states will probably be using these,
# so I am putting them here
# To the left or to the right?
func getDirection():
	_character.direction = Input.get_vector(GameContants.UserInputs.MOVE_LEFT, GameContants.UserInputs.MOVE_RIGHT, GameContants.UserInputs.MOVE_UP, GameContants.UserInputs.MOVE_DOWN)

# At least we understand the gravity of the situation.
func applyGravity(delta, slowFall : bool = false):
	# Capture input states and character properties for readability
	var isJumpPressed = Input.is_action_pressed(GameContants.UserInputs.JUMP)
	var isOnFloor = _character.is_on_floor()
	var gravityForce = _character.gravity * delta
	if slowFall :
		_character.velocity.y = min((_character.velocity.y + (_character.wall_slide_gravity_factor * gravityForce)), _character.max_slide_speed)
	elif isJumpPressed and not isOnFloor:
		# Apply different gravity rates based on jump build velocity state when in the air
		_character.velocity.y += (1.35 if not _character.jumpBuildVelocity_active else 1.5) * gravityForce
	elif not isOnFloor and _character.velocity.length() <= _character.max_gravity:
		# Apply normal gravity force when not jumping and in the air
		_character.velocity.y = min((_character.velocity.y + (2 * gravityForce)), _character.max_gravity)
	

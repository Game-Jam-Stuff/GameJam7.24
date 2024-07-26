class_name characterJumpState
extends PlayerState

var jump_modifier = 1


func _ready():
	print("Jump Ready")
	super._ready()

# Called every time state is entered
func Enter(_msg := {}) -> void:
	print("Jump Enter")
	_character.stateLabel.text = "JumpState"
	if _msg.has("hurt"):
		#_character._animations.play(GameContants.PlayerAnimations.ANIM_HURT)
		pass
	if _msg.has("do_jump"):
		var _delta = _msg.get("_delta")
		Jump(_delta)
	if _character.is_hanging and jump_modifier == 1:
		jump_modifier = 0.6
	else:
		jump_modifier = 1
		
func Exit():
	_character.is_hanging = false
	jump_modifier = 1
	
# Called during the physics update step
func PhysicsUpdate(delta: float) -> void:
	Jump(delta)
	
	
func Jump(delta):
	
	getDirection()
	applyGravity(delta)
	handleJump(delta)
	handleAirMovement(delta)
	super.PhysicsUpdate(delta)
	handleStateChange(delta)
	handleAnimations()


# We are Jumping
func handleJump(delta):
	if _character.is_on_floor() or _character.jump_CoyoteTime.time_left > 0.0 or _character.is_hanging:
		handleGroundJump(delta)
	elif not _character.is_on_floor():
		handleAirJump(delta)

func handleGroundJump(delta):
	# Did we jump?
	if Input.is_action_just_pressed(GameContants.UserInputs.JUMP):
		# These are for "charging jumps" so how long you hold the space bar
		# should affect your jump height
		_character.jumpBuildVelocity.start()
		_character.jumpBuildVelocity_active = true		
	# See above
	if _character.jumpBuildVelocity_active and Input.is_action_pressed(GameContants.UserInputs.JUMP):
		_character.velocity.y = move_toward(_character.velocity.y, _character.jump_force * jump_modifier, 65 * _character.acceleration * delta)

func handleAirJump(delta):
	_character.justJumpedBuffer -= 1
	
	# Slow down jump on Space Bar release.
	if Input.is_action_just_released(GameContants.UserInputs.JUMP) and _character.velocity.y < _character.jump_force / 2:
		_character.velocity.y = move_toward(_character.velocity.y, _character.jump_force / 2, 45 * _character.acceleration * delta)
	
	# Double Jumping
	if Input.is_action_just_pressed(GameContants.UserInputs.JUMP) and not _character.double_jump:
		#if _character.is_hanging:
			#_character.velocity.y = move_toward(_character.velocity.y, _character.jump_force * 0.5, 105 * _character.acceleration * delta)
			
		if _character.velocity.y < _character.jump_force / 2:
			# This is the double jump. It doesn't go as high as the first jump, but we need to 
			# accelerate faster to make sure the effect happens
			_character.velocity.y = move_toward(_character.velocity.y, _character.jump_force * 0.9, 105 * _character.acceleration * delta)
		else:
			_character.velocity.y = move_toward(_character.velocity.y,  _character.jump_force * 0.9, 135 * _character.acceleration * delta)
			_character.double_jump = true
			
func handleAnimations():
	var is_jumping = (_character.gravity > 0 and _character.velocity.y < 0) or (_character.gravity < 0 and _character.velocity.y > 0)
	var is_falling = (_character.gravity > 0 and _character.velocity.y > 0) or (_character.gravity < 0 and _character.velocity.y < 0)
	if !_character.hurtPlaying:
		if is_jumping:
			_character._animations.play(GameContants.PlayerAnimations.ANIM_JUMPING)
		elif is_falling:
			_character._animations.play(GameContants.PlayerAnimations.ANIM_FALLING)


func handleAirMovement(delta):
	if _character.direction.x != 0:
		# This functions allow for changes in speed, so a more realistic acceleration.
		_character.velocity.x = move_toward(_character.velocity.x,  _character.direction.x * _character.air_speed, _character.air_acceleration * delta)
	else:
		# If we are stopping, let's slow down and gradually come to a stop. It's more realistic and fluid.
		_character.velocity.x = move_toward(_character.velocity.x, 0, _character.friction * delta)

	

func handleStateChange(delta):
	if Input.is_action_just_pressed(GameContants.UserInputs.DASH) and _character.can_dash:
		_stateMachine.transition_to(GameContants.PlayerStates.DASH)
	elif _character.is_on_floor() and not _character.onWall:
		_stateMachine.transition_to(GameContants.PlayerStates.MOVE)
		
	elif _character.onWall and not _character.is_on_floor() and _character.canWallJump:
		_stateMachine.transition_to(GameContants.PlayerStates.WALL, {_delta = delta})



func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == GameContants.PlayerAnimations.ANIM_HURT:
		_character.hurtPlaying = true # Replace with function body.


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == GameContants.PlayerAnimations.ANIM_HURT:
		_character.hurtPlaying = false # Replace with function body.

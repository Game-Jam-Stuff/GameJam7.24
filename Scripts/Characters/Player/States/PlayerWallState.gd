class_name PlayerWallState
extends PlayerState

var moveTween : Tween
var slowFall = false
var falldir
var lastJumpDirection
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Wall Ready")
	super._ready()

# Called Every Time State is entered
func Enter(_msg := {}) -> void:
	print("Wall Enter");
	_character.stateLabel.text = "WallState"
	var delta = _msg.get("_delta")
	moveTween = get_tree().create_tween()
	moveTween.tween_property(_character, "velocity", Vector2.ZERO, 0.01).set_trans(Tween.TRANS_SINE).from_current().set_ease(Tween.EASE_IN_OUT)
	slowFall = true
	#_character.wallSlideTimer.start()
	handleWallState(delta)

func Exit():
	#_character.wallSlideTimer.stop()
	_character.wall_jumping = false
	
func PhysicsUpdate(delta: float) -> void:
	handleWallState(delta)


func handleWallState(delta):
	applyGravity(delta, slowFall)
	handleWallJump(delta)
	super.PhysicsUpdate(delta)
	handleStateChange()

func handleWallJump(delta):
	# Are we actually Wall Jumping?
	if Input.is_action_pressed(GameContants.UserInputs.JUMP):
		if (Input.is_action_pressed(GameContants.UserInputs.MOVE_LEFT) and _character._spriteNode.flip_h == false) or (Input.is_action_pressed(GameContants.UserInputs.MOVE_RIGHT) and _character._spriteNode.flip_h == true):
			lastJumpDirection = _character.direction.x
			_character.velocity.x = _character.wall_jump_horizontal_force * (-1 if _character._spriteNode.flip_h == false else 1)
			_character.velocity.y = _character.wall_jump_vertical_force
			_stateMachine.transition_to(GameContants.PlayerStates.JUMP)


func Flippy():
	if _character.direction.x != 0:
		_character._spriteNode.flip_h = _character.direction.x < 0
		_character.headDetector.rotation_degrees = (180 if _character._spriteNode.flip_h else 0)
		_character.torsoDetector.rotation_degrees = (180 if _character._spriteNode.flip_h else 0)

func handleStateChange():
	if _character.onWall and !_character.is_on_floor():
		return
	if _character.is_on_floor():
		_stateMachine.transition_to(GameContants.PlayerStates.MOVE)


func _on_wall_slide_timer_timeout():
	slowFall = false
	falldir = Vector2((-0.25 if _character._spriteNode.flip_h else -0.25) ,1).normalized() *  (500)
	moveTween = get_tree().create_tween()
	moveTween.tween_property(_character, "velocity", falldir, 0.01).set_trans(Tween.TRANS_LINEAR).from_current().set_ease(Tween.EASE_IN_OUT)
	_stateMachine.transition_to(GameContants.PlayerStates.JUMP)
	
	

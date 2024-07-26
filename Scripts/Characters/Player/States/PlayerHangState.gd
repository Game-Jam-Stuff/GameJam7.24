class_name PlayerHangState
extends PlayerState

var moveTween : Tween
var movextween : Tween
var zone : HangZone 
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hang Ready")
	super._ready()

# Called Every Time State is entered
func Enter(_msg := {}) -> void:
	print("Hang Enter");
	_character.stateLabel.text = "HangState"
	var pos : Vector2 = _msg.get("pos")
	zone = _msg.get("zone")
	moveTween = get_tree().create_tween()
	moveTween.set_parallel(true)
	moveTween.tween_property(_character, "position", pos, 0.2).set_trans(Tween.TRANS_SINE).from_current().set_ease(Tween.EASE_IN_OUT)
	moveTween.tween_property(_character, "velocity", Vector2.ZERO, 0.2).set_trans(Tween.TRANS_SINE).from_current().set_ease(Tween.EASE_IN_OUT)
	_character.is_hanging = true
	_character._animations.play(GameContants.PlayerAnimations.ANIM_HANGING)


func Exit(_msg := {}) -> void:
	zone.colTimer.start()
	_character.double_jump = false



func PhysicsUpdate(_delta: float) -> void:
	getDirection()
	Flippy()
	handleStateChange(_delta)

	
	
	
func handleStateChange(delta):

	if Input.is_action_just_pressed(GameContants.UserInputs.JUMP):

		var jumpdir = Vector2((-1 if _character._spriteNode.flip_h else 1) ,-0.5).normalized() *  (_character.gravity / 3)
		moveTween = get_tree().create_tween()
		moveTween.tween_property(_character, "velocity", jumpdir, 0.1).set_trans(Tween.TRANS_LINEAR).from_current().set_ease(Tween.EASE_IN_OUT)
		moveTween = get_tree().create_tween()
		moveTween.tween_property(_character, "velocity", jumpdir, 0.1).set_trans(Tween.TRANS_LINEAR).from_current().set_ease(Tween.EASE_IN_OUT)
		super.PhysicsUpdate(delta)
		_stateMachine.transition_to(GameContants.PlayerStates.JUMP, {do_jump = true, _delta = delta})
		
		
	
	elif Input.is_action_just_pressed(GameContants.UserInputs.MOVE_DOWN):
		var gravity = _character.gravity * Vector2.DOWN
		#moveTween = get_tree().create_tween()
		#moveTween.tween_property(_character, "velocity", gravity, 0.5).set_trans(Tween.TRANS_LINEAR).from_current().set_ease(Tween.EASE_IN_OUT)
		super.PhysicsUpdate(delta)
		_stateMachine.transition_to(GameContants.PlayerStates.JUMP)
		
	elif _character.is_on_floor():
		_stateMachine.transition_to(GameContants.PlayerStates.MOVE)

func Flippy():
	if _character.direction.x != 0:
		_character._spriteNode.flip_h = _character.direction.x < 0
		_character.headDetector.rotation_degrees = (180 if _character._spriteNode.flip_h else 0)
		_character.torsoDetector.rotation_degrees = (180 if _character._spriteNode.flip_h else 0)
	
func jumpOffHang(newVals : Vector2):
	_character.velocity.y = newVals.y
	_character.velocity.x = newVals.x

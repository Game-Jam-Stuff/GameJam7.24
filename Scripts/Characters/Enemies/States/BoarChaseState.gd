class_name  EnemyChaseState
extends EnemyState

var target : Player 

func _ready():
	print("Chase Ready")
	super._ready()

# Called Every Time State is entered
func Enter(_msg := {}) -> void:
	print("Chase Enter");
	_character.stateLabel.text = "ChaseState"
	_character._animations.play(GameContants.EnemyAnimations.ANIM_MOVING)
	getTarget()
	
func Exit():
	_character.direction.x == (-1 if _character._spriteNode.flip_h == true else 1)	

func PhysicsUpdate(delta):
	applyGravity(delta)
	moveTo()
	super.PhysicsUpdate(delta)
	handleStateChange()

func handleStateChange():
	if (_character.inChargeZone and not (_character.inAttackZone or _character.noChargeZone)) and _character.canCharge == true:
		_stateMachine.transition_to(GameContants.EnemyStates.CHARGE)
	if _character.inAttackZone:
		_stateMachine.transition_to(GameContants.EnemyStates.ATTACK)


func _on_leave_chase_timer_timeout() -> void:
	_stateMachine.transition_to(GameContants.EnemyStates.PATROL) # Replace with function body.


func _on_calculate_timer_timeout() -> void:
	getTarget() # Replace with function body.


func getTarget():
	if $LeaveChaseTimer.is_stopped():
		target = _character.startSeekArea.get_overlapping_bodies().front()
		if target:
			destination = target.global_position
			_character.chaseTimeOut.start()

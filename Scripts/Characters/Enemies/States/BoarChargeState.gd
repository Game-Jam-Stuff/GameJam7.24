class_name BoarCharge
extends EnemyState

@export_range(0, 20, 0.1) var charge_speed = 10
@export var charge_Timer : Timer

var velX 
var idleTime = false
@onready var pauseTimer = $PT2 

var target : Player 

func _ready():
	print("Charge Ready")
	super._ready()

# Called Every Time State is entered
func Enter(_msg := {}) -> void:
	print("Charge Enter");
	_character.stateLabel.text = "ChargeState"
	target = _character.startSeekArea.get_overlapping_bodies().front()
	destination = target.global_position
	_character.direction.x = _character.global_position.direction_to(destination).x
	_character.velocity.x = _character.direction.x * _character.run_speed
	velX = _character.velocity.x 
	_character.velocity = Vector2.ZERO
	flippy()
	idlePause()
	

func PhysicsUpdate(_delta: float) -> void:
	super.PhysicsUpdate(_delta)


func idlePause():
	if _character.velocity.x == 0:
		if not idleTime:
			pauseTimer.start()
			print("Idle Enter");
			_character.stateLabel.text = "IdleState"
			_character._animations.play(GameContants.EnemyAnimations.ANIM_IDLE)
			idleTime = true

func _on_charge_timer_timeout() -> void:
	_character.velocity = Vector2.ZERO
	_stateMachine.transition_to(GameContants.EnemyStates.CHASE)
	chargeCooldown.start()
	_character.canCharge = false


func _on_charge_cooldown_timer_timeout() -> void:
	_character.canCharge = true # Replace with function body.


func charge():
	_character.velocity.x = velX
	_character.velocity.x *= charge_speed
	_character._animations.play(GameContants.EnemyAnimations.ANIM_MOVING, -1, 2)
	charge_Timer.start()

func _on_pt_2_timeout() -> void:
	idleTime = false
	charge() # Replace with function body.

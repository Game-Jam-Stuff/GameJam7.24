class_name BoarAttackState
extends EnemyState

@onready var attackTimer = $"AttackTimer(temp)"

var target : Player 

func _ready():
	print("Attack Ready")
	super._ready()

# Called Every Time State is entered
func Enter(_msg := {}) -> void:
	print("Attack Enter");
	_character.velocity = Vector2.ZERO
	_character.stateLabel.text = "AttackState"
	_character._animations.play(GameContants.EnemyAnimations.ANIM_IDLE)
	attackTimer.start()


func Exit():
	_character.inAttackZone = false

func _on_attack_timertemp_timeout() -> void:
	_stateMachine.transition_to(GameContants.EnemyStates.CHASE)

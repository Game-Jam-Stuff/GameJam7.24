class_name PlayerDashState
extends PlayerState

@export_range(0, 20, 0.1) var dash_speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Dash Ready")
	super._ready()

# Called Every Time State is entered
func Enter(_msg := {}) -> void:
	print("Dash Enter");
	_character.stateLabel.text = "DashState"
	_character._animations.play(GameContants.PlayerAnimations.ANIM_DASHING)
	getDirection()
	if _character.velocity == Vector2.ZERO:
		_character.velocity.x = _character.run_speed * (-1 if _character._spriteNode.flip_h else 1)
	_character.velocity.x *= dash_speed
	_character.dash_Timer.start()

func PhysicsUpdate(_delta: float) -> void:
	super.PhysicsUpdate(_delta)

func _on_dash_timer_timeout():
	_character.velocity = Vector2.ZERO
	_stateMachine.transition_to(GameContants.PlayerStates.MOVE)
	_character.dash_CooldownTimer.start()
	_character.can_dash = false


func _on_dash_cooldown_timer_timeout():
	_character.can_dash = true

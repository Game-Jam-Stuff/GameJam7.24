class_name PlayerHurtState
extends PlayerState

var hitTween : Tween
var damage
var canDodge

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hurt Ready")
	super._ready()

# Called Every Time State is entered
func Enter(_msg := {}) -> void:
	print("Hurt Enter");
	_character.stateLabel.text = "HurtState"
	_character._animations.play(GameContants.PlayerAnimations.ANIM_HURT)
	damage = _msg.get("_damage")
	canDodge =  _msg.get("_canDodge")
	if canDodge:
		_character.dodgeRNG.randomize()
		if _character.dodgeRNG.ranf() < _character.dodgeChance:
			_stateMachine.transition_to(GameContants.PlayerStates.MOVE)
	
	handleHit()
	takeDamage(damage)
	

func Exit(_msg := {}) -> void:
	pass
	

func PhysicsUpdate(_delta: float) -> void:
	super.PhysicsUpdate(_delta)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func Update(_delta: float) -> void:
	pass

func handleHit():
	hitAnimation()

## Temp Function
func hitAnimation():
	var gravity = _character.gravity * Vector2.DOWN
	var jumpdir = Vector2((1 if _character._spriteNode.flip_h else -1) ,-1).normalized() *  (_character.gravity / 1.5)
	hitTween = get_tree().create_tween()
	hitTween.tween_property(_character, "velocity", jumpdir, 0.1).set_trans(Tween.TRANS_BOUNCE).from_current().set_ease(Tween.EASE_IN_OUT)
	
	

	
	
	
	
func takeDamage(damage):
	var beforeHealthString = "Before Player Health %d."
	var beforeFullString = beforeHealthString % _character.health
	print(beforeFullString)
	var damageString = "Damage Done %d."
	var dFstring = damageString % damage
	print(dFstring)
	_character.health -= damage
	if _character.health <= 0:
			_stateMachine.transition_to(GameContants.PlayerStates.DEAD)
	else:
		var healthString = "New Player Health %d."
		var fullString = healthString % _character.health
		print(fullString)
		_character.healthLabel.text = str(_character.health)
		_stateMachine.transition_to(GameContants.PlayerStates.JUMP, {hurt = true}) # Replace with function body.

class_name  EnemyPatrolState
extends EnemyState
var pauseRandom = RandomNumberGenerator.new()
var oldDir = 0
var idleTime = false
@onready var pauseTimer = $PauseTimer

func _ready():
	print("Patrol Ready")
	super._ready()

# Called Every Time State is entered
func Enter(_msg := {}) -> void:
	print("Patrol Enter");
	_character.stateLabel.text = "PatrolState"
	print(abs(_character.direction.x))
	_character._animations.play(GameContants.EnemyAnimations.ANIM_MOVING)


func PhysicsUpdate(delta):
	applyGravity(delta)
	handleSideMovement(delta)
	idlePause()
	super.PhysicsUpdate(delta)


func handleSideMovement(delta):
	if _character.direction.x != 0:
		# This functions allow for changes in speed, so a more realistic acceleration.
		_character.velocity.x = move_toward(_character.velocity.x,  _character.direction.x * _character.run_speed, _character.acceleration * delta)
	else:
		# If we are stopping, let's slow down and gradually come to a stop. It's more realistic and fluid.
		_character.velocity.x = move_toward(_character.velocity.x, 0, _character.friction * delta)

func idlePause():
	if _character.velocity.x == 0:
		if not idleTime:
			pauseRandom.randomize()
			var wt = pauseRandom.randf_range(0.5, 2)
			print(wt)
			pauseTimer.wait_time = wt
			pauseTimer.start()
			print("Idle Enter");
			_character.stateLabel.text = "IdleState"
			_character._animations.play(GameContants.EnemyAnimations.ANIM_IDLE)
			idleTime = true

func bounce():
	if _character.velocity.x == 0:
		_character.direction.x = -oldDir
	if abs(_character.direction.x) == 0:
		_character.direction.x == (-1 if _character._spriteNode.flip_h == true else 1)

func _on_wall_wall_entered():
	idlePause()


func _near_wall_wall_entered():
	oldDir = _character.direction.x
	_character.direction.x = 0


func handleStateChange():
	pass


func _on_pause_timer_timeout() -> void:
	print("Patrol Enter");
	_character.stateLabel.text = "PatrolState"
	_character._animations.play(GameContants.EnemyAnimations.ANIM_MOVING)
	idleTime = false
	bounce() # Replace with function body.

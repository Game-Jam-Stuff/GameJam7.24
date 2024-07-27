class_name  EnemyIdleState
extends EnemyState

@onready var pauseTimer = $PauseTimer

var pauseRandom = RandomNumberGenerator.new()
var idleTime = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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

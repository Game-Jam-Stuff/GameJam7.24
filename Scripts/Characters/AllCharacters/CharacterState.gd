class_name CharacterState
extends State

var _character

func _ready():
	# Use call_deferred to safely wait for the owner to be ready
	call_deferred("initialize")
	_character = owner as Character

func initialize():
	# Check if _character is properly assigned to avoid unintended bugs
	if _character == null:
		push_error("Player is null in the CharacterState type check.")

func Update(_delta):
	pass

func PhysicsUpdate(_delta):
	# We move the player and update position checks.
	_character.move_and_slide()
	if not _character.hurtPlaying:
		_Flip()	


# Ensure character is facing the correct direction based on velocity
func _Flip():
	if _character.velocity.x != 0:
		_character._spriteNode.flip_h = _character.velocity.x < 0
		_character.headDetector.rotation_degrees = (180 if _character._spriteNode.flip_h else 0)
		_character.torsoDetector.rotation_degrees = (180 if _character._spriteNode.flip_h else 0)




# This function is one I was using to test things. I may use it later. Or I may not.
func equal_approx(a: float, b: float) -> bool:
	return abs(a - b) < 0.00005

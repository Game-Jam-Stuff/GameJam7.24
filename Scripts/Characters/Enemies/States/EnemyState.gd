class_name EnemyState
extends CharacterState
@export var chargeCooldown : Timer
var destination : Vector2

func applyGravity(delta):
	var isOnFloor = _character.is_on_floor()
	var gravityForce = _character.gravity * delta
	if  not isOnFloor and _character.velocity.length() <= _character.max_gravity:
		# Apply normal gravity force when not jumping and in the air
		_character.velocity.y = min((_character.velocity.y + (2 * gravityForce)), _character.max_gravity)
		

func Jump():
	pass

func PhysicsUpdate(_delta):
	# We move the player and update position checks.
	_character.move_and_slide()
	flippy()


func moveTo():
	_character.velocity.x = _character.global_position.direction_to(destination).x * _character.run_speed
	
func flippy():
	if _character.velocity.x != 0:
		_character._spriteNode.flip_h = !_character.velocity.x < 0
		_character.hitBox.position.x = (40 if _character._spriteNode.flip_h else -40)
		#_character.headDetector.rotation_degrees = (0 if _character._spriteNode.flip_h else 180)
		_character.torsoDetector.rotation_degrees = (0 if _character._spriteNode.flip_h else 180)

class_name InvertZone
extends Area2D

var _character

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# When we enter the zone, flip the gravity.
# IMPORTANT NOTE: THE CONTROLS DO NOT CHANGE IN INVERT ZONES.
func _on_body_entered(body):
	if not body is Character:
		return
	_character = body as Character
	print("Entered Flip")
	flip_gravity()

# When we leave the zone, flip it back.
func _on_body_exited(body):
	if not body is Character:
		return
	_character = body as Character
	print("Exited Flip")
	flip_gravity()
	
	
func flip_gravity():
	_character.gravity = -_character.gravity
	_character.up_direction = -_character.up_direction
	_character.jump_force = -_character.jump_force
	_character._spriteNode.flip_v = !_character._spriteNode.flip_v

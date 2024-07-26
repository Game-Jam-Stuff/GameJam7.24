class_name PlayerAttackState
extends PlayerState


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Attack Ready")
	super._ready()

# Called Every Time State is entered
func Enter(_msg := {}) -> void:
	print("Attack Enter");
	_character.stateLabel.text = "AttackState"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

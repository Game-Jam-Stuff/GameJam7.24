class_name PlayerIsDeadState
extends PlayerState


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Dead Ready")
	super._ready()


func Enter(_msg := {}) -> void:
	print("Dead Enter");
	_character.stateLabel.text = "DeadState"
	call_deferred("weDead")
	
func weDead():
	_character.died.emit()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



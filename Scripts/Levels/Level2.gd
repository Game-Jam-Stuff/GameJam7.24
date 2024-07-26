extends Level

@onready var checkpoint = $CheckPoint
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	checkpoint.move_to_checkpoint(player) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	if Input.is_action_just_pressed(GameContants.UserInputs.DIE):
		player._stateMachine.transition_to(GameContants.PlayerStates.DEAD)
		

func _on_player_died():
	get_tree().reload_current_scene()


func _on_return_to_overworld_door_door_player_entered() -> void:
	TeleportData.current_portal.teleport_out() # Replace with function body.  # Replace with function body.

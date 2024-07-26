class_name Platform1
extends Level


@onready var checkpoint = $CheckPoint

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	checkpoint.move_to_checkpoint(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	if Input.is_action_just_pressed(GameContants.UserInputs.DIE):
		player._stateMachine.transition_to(GameContants.PlayerStates.DEAD)


func _on_over_world_door_player_entered():
	GameLog.set_in_beginning(false)
	TeleportData.current_portal.teleport_out() # Replace with function body. 


func _on_player_died():
	get_tree().reload_current_scene()

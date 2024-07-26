class_name OverWorld
extends Level

@export var isbeginning : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_platform_level_1_door_player_entered():
	TeleportData.current_portal.teleport_out() # Replace with function body.


func _on_level_2_door_player_entered() -> void:
	TeleportData.current_portal.teleport_out() # Replace with function body

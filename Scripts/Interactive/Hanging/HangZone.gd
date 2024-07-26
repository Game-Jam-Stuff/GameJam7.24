class_name HangZone
extends  InteractiveArea

@export var player : Player
@export var Collision : CollisionShape2D
@onready var Marker : Marker2D = $Marker2D
@onready var colTimer : Timer = $ColisionTimer
signal Hanging
# Called when the node enters the scene tree for the first time.


func _on_interacted():
	var pos = Marker.position + Marker.global_position
	player._stateMachine.transition_to(GameContants.PlayerStates.HANG, {pos = pos, zone = self})
	call_deferred("disable_collision")
	interaction_unavailable.emit()


func disable_collision():
	Collision.disabled = true


func _on_colision_timer_timeout():
	Collision.disabled = false

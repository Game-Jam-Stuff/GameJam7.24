class_name InteractiveArea
extends Area2D

signal interacted
signal interaction_available
signal interaction_unavailable
@export var ButtonZone : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_unhandled_input(false)



func _unhandled_input(event):
	if event.is_action_pressed(GameContants.UserInputs.INTERACT):
		print("hit the button")
		interacted.emit()
		get_viewport().set_input_as_handled()



func _on_area_entered(_area):
	set_process_unhandled_input(true)
	print("can interact")
	interaction_available.emit()
	if not ButtonZone:
		interacted.emit()


func _on_area_exited(_area):
	set_process_unhandled_input(false)
	print("can no longer interact")
	interaction_unavailable.emit()

class_name Level
extends Node2D

@export var Hangers : Node

@onready var player = $Player



func _ready():
	call_deferred("initializeHangers")


func _on_player_character_2d_died():
	get_tree().reload_current_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	Capture_Screen()




func Capture_Screen():
	if Input.is_action_just_pressed(GameContants.UserInputs.SCREENSHOT):
		var img = get_viewport().get_texture().get_image()
		# Save the image to a file
		var file_path = "res://scene_capture.png"
		img.save_png(file_path)

		print("Scene captured and saved to: " + file_path)


func initializeHangers():
	if Hangers:
		for child in Hangers.get_children():
			if child is HangZone:
				child.player = player

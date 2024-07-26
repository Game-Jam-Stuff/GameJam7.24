class_name Portal2D
extends InteractiveArea

@export_file("*.tscn") var next_scene_path
@export var target_portal_name = "Portal2D"
@export var canTeleportBack : bool

func  _ready():
	TeleportData.teleport_back = canTeleportBack
	super._ready()

func teleport_in(object):
	object.global_position = global_position


func teleport_out(next_scene = next_scene_path):
	TeleportData.target_portal_name = target_portal_name

	SceneLoader.load_scene(next_scene)


func _on_interaction_available():
	TeleportData.current_portal = self




class_name CheckPoint
extends Node2D

@export var checkpoint_data: Resource
@export var incremental = false
@export var persistent = true
@export var user_file_path = "user://testing-level/checkpoint_data.tres"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_children_signals()
	if persistent:
		load_checkpoint_data()


func move_to_checkpoint(object, point = checkpoint_data.current_checkpoint_index):
	object.global_position = get_child(point).global_position


func load_checkpoint_data(data_path = user_file_path):
	if FileAccess.file_exists(data_path):
			checkpoint_data = ResourceLoader.load(data_path)
	else:
		DirAccess.make_dir_recursive_absolute(data_path.get_base_dir())
		save_checkpoint_data()


func save_checkpoint_data(data_path = user_file_path):
	if FileAccess.file_exists(data_path):
		ResourceSaver.save(checkpoint_data, data_path)


func connect_children_signals():
	for child in get_children():
		child.interaction_available.connect(
			self._on_interaction_available.bind(child.get_index())
		)


func _on_interaction_available(check_point_index):
	if incremental:
		if check_point_index > checkpoint_data.current_checkpoint_index:
			checkpoint_data.current_checkpoint_index = check_point_index
	else:
		checkpoint_data.current_checkpoint_index = check_point_index
	save_checkpoint_data()

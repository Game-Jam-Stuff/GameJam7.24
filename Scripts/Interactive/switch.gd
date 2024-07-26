class_name Switch
extends InteractiveArea

@export var target_object_path: NodePath
@export var target_switch_method = "switch"

var target_object


func _ready():
	if get_node_or_null(target_object_path):
		target_object = get_node(target_object_path)


func toggle(_target_object = target_object):
	if _target_object.has_method(target_switch_method):
		_target_object.call(target_switch_method)

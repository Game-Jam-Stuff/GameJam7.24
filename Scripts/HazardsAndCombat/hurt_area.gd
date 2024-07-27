class_name HurtArea
extends Area2D

signal hurt(damage, canDodge, hit_direction)

@export var defense = 0
@export_enum("Not Player", "Player", "Neutral") var team = 0

func _ready():
	print(defense)


func get_hurt(hit_area):
	if not hit_area.team == team:
		hurt.emit(max(0, hit_area.damage - defense), hit_area.canDodge, hit_area.hit_direction)

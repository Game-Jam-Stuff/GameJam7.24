class_name Enemy
extends Character

@export_group("Enemy Nodes")
@export_subgroup("Navigation and Path")
@export var _enemyPath : Path2D
@export var _navigation : NavigationAgent2D
@export var startSeekArea : Area2D
@export var stopSeekArea : Area2D
@export var chaseTimeOut : Timer

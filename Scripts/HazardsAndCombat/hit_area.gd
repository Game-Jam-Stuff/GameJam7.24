class_name HitArea
extends Area2D

signal hit_landed(damage, canDodge, hit_direction)

## How much damage the attack does
@export var damage = 2
## Can the attack be dodged?
@export var canDodge : bool = true
var hit_direction
## Who does the attack hit? Enemies, Player or Everyone.
## Think of this 
@export_enum("Not Player", "Player", "Neutral") var team = 0



func hit(hurt_area):
	if not hurt_area.team == team:
		hit_direction = (hurt_area.global_position - global_position).normalized()
		hit_landed.emit(max(0, damage - hurt_area.defense), canDodge)
		hurt_area.get_hurt(self)


func _on_area_entered(area2D):
	hit(area2D)

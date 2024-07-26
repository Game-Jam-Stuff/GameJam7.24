extends RayCast2D

signal wall_entered
signal wall_exited

var wall_colliding = false


func _physics_process(_delta):
	if is_colliding():
		if not wall_colliding:
			wall_entered.emit()
			wall_colliding = true
			print("Colliding")
		
	else:
		if wall_colliding:
			wall_exited.emit()
			wall_colliding = false
			print("No longer Colliding")
			

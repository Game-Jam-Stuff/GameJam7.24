class_name HeadDetector
extends RayCast2D

signal headOnWall
signal headOffWall

var head_colliding = false


func _physics_process(_delta):
	if is_colliding():
		if not head_colliding:
			headOnWall.emit()
			head_colliding = true
			print("Colliding")
		
	else:
		if head_colliding:
			headOffWall.emit()
			head_colliding = false
			print("No longer Colliding")
			

class_name BasicBadGuy
extends Enemy

var inChargeZone = false
var inAttackZone = false
var canCharge = true
var canChase = false

func _ready():
	direction.x = 1




func _on_seeking_area_body_entered(body: Node2D) -> void:
	if not body is Player:
		return
	var _character = body as Player
	print("player entered")
	_stateMachine.transition_to("ChaseState")


func _on_seeking_area_body_exited(body: Node2D) -> void:
	if not body is Player:
		return
	var _character = body as Player
	
	$State_Machine/ChaseState/LeaveChaseTimer.start()


func _on_charge_area_body_entered(body: Node2D) -> void:
	if !body is Player:
		return
	else: 
		inChargeZone = true
		print(inChargeZone)


func _on_charge_area_body_exited(body: Node2D) -> void:
	if !body is Player:
		return
	else: 
		inChargeZone = false # Replace with function body.
		print(inChargeZone)


func _on_attack_area_body_entered(body: Node2D) -> void:
	if !body is Player:
		return
	else: 
		inAttackZone = true # Replace with function body.
		print(inAttackZone) # Replace with function body.
		_stateMachine.transition_to(GameContants.EnemyStates.ATTACK)


func _on_attack_area_body_exited(body: Node2D) -> void:
	if !body is Player:
		return
	else: 
		inAttackZone = false # Replace with function body.
		print(inAttackZone) # Replace with function body.


func _on_start_seeking_area_body_entered(body: Node2D) -> void:
	pass # Replace with function body.

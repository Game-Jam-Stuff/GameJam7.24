class_name LevelDoor
extends AnimatableBody2D
enum doorDirection {UP, DOWN}
## NOTE: This refers to the direction the door moves to open.
@export var upordown : doorDirection
@export var autoclose = true
@export var closeTimer : Timer
@export var openSpeedScale = 1
@export var closeSpeedScale = 1
@export var Locked : bool
@onready var anim = $AnimationPlayer
@onready var InteractionZone = $Interact


var open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_door_interacted():
	if !Locked:
		openOrClose()
		
		
	


func _on_animation_player_animation_finished(anim_name):
	if autoclose and open:
		closeTimer.start()
	Locked = false
	set_collision_mask_value(2, !open)
		


func _on_close_timer_timeout():
	if !Locked:
		openOrClose()

func openOrClose():
	if open:
		anim.speed_scale = openSpeedScale
	else:
		anim.speed_scale = closeSpeedScale
	match upordown:
		doorDirection.UP:
			if !open:
				open = true
				anim.play("OpenUp")
				Locked = true
			else:
				anim.play_backwards("OpenUp")
				open = false
				Locked = true
		doorDirection.DOWN:
			if !open:
				open = true
				anim.play("OpenDown")
				Locked = true
			else:
				anim.play_backwards("OpenDown")
				open = false
				Locked = true
				




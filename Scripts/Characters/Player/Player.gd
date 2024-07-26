class_name Player
extends Character

# Add Health and Stamina
# Dash and wall jump tied to stamina
# Hazards some drop by portion
# Some insta kills
# For Players Only
@export_group("Player Nodes")
@export_subgroup("Jump Timers")
# Jump and Wall Jump
@export var jumpBuildVelocity : Timer


@export_subgroup("Collisions and Hitboxes")
# Collisions and Hitbox
@export var character_Collision : CollisionShape2D
@export var interactArea : Area2D
#@onready var character_Hitbox = $characterHitbox/CollisionShape2D


@export_subgroup("Camera")
# Camera
@export var camera : Camera2D

@export_subgroup("Dash Timers")
# Dash Timers
@export var dash_Timer : Timer
@export var dash_CooldownTimer : Timer

# Wall Jump Timers
@export_subgroup("Wall Jump Timers")
@export var wallSlideTimer : Timer



@onready var CollZone = $CollisionZone



func _ready():
	super._ready()
	print(hurtBox.defense)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	super._process(_delta)

	
func _physics_process(_delta):
	super._physics_process(_delta)

## When you see the _ in front of variable names in state changes, 
## those are just to help me differentiate the key from the value.
func _on_hurt_area_hurt(damage, canDodge):
	_stateMachine.transition_to(GameContants.PlayerStates.HURT, {_damage = damage, _canDodge = canDodge})


func canGrab():
	var oCGL = canGrabLedge
	canGrabLedge = onWall and not headOnWall
	if oCGL != canGrabLedge:
		var ocglstring = "canGrabLedge: %s" 
		var nstring = ocglstring % canGrabLedge
		print(nstring)




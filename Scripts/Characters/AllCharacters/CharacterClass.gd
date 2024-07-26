class_name Character
extends CharacterBody2D
## This is the base Character Class. All characters, including the player and NPCs
## will be built off this class.
## These are the 2 different types of movement available to be used.
enum movementTypes {TOPDOWN, SIDE}
## Data for Character Movement
@export_group("Character Movement Data")
#@export var characterData : characterMovementData
@export_subgroup("Movement Parameters")
## Which Movement Type is being used. It will probably always be side.
@export var movementType : movementTypes = movementTypes.SIDE
@export var run_speed = 250
@export var air_speed = 225
@export var acceleration = 1000
@export var air_acceleration = 800
@export var deceleration = 1000
@export var friction = 800
@export var air_resistance = 700
@export var jump_force = -600 

## Terminal Velocity
@export var max_gravity = 1500
## How much the speed is affected when crouching
@export var crouchMultiplier = 0.7
## The amount by which we multiply the gravity
@export_range(0, 3, 0.1) var gravityScale = 1

## The Layer used for pass through Physics
@export_flags_2d_physics var pass_through_layer = 3
@export_flags_2d_physics var interact_layer = 4

## Wall jump parameters
@export_subgroup("Wall Jump Parameters")
@export var wall_jump_horizontal_force = 400
@export var wall_jump_vertical_force = -200
## The amount by which we multiply the gravity when wall sliding
@export var wall_slide_gravity_factor = 0.2
## Terminal Velocity for wall sliding
@export var max_slide_speed = 200


## The Animations
@export_subgroup("Sprite and Animations")
@export var _spriteNode = AnimatedSprite2D
@export var _animations = AnimationPlayer

@export_subgroup("Health and Stamina")
## We are doing Hearts for this game. I was gonna go down by half hearts
@export var health : int = 10
## Used for dash and wall Jump?
@export var stamina : int = 15

@export_subgroup("Combat Stats")
## The odds of the character to avoid taking damage when hit, if the damage can be avoided.
@export var dodgeChance : float = 0.1
@export_range(0, 3, 0.2) var defense : float = 2

## State Machine
@export_subgroup("State Machine")
@export var _stateMachine : State_Machine

## Jump and Wall Jump Timers
@export_subgroup("Jump Timers")
@export var jump_CoyoteTime : Timer
@export var wall_jump_CoyoteTime : Timer


@export_subgroup("Wall Detectors")
@export var torsoDetector : RayCast2D
@export var headDetector : RayCast2D



## Tools for debugging
@export_subgroup("Debug Tools")
# Debug Labels
@export var stateLabel : Label
@export var stateLabelOn : bool = false
@export var healthLabel : Label
@export var healthLabelOn : bool = false
## Debug Line used for troubleshooting character movement
@export var debugLine : bool = false
@export var debugPathLine : Line2D

## On Ready
## Start Pos, for saving
@onready var start_pos = global_position

## Interactions
@onready var interactZone : Area2D = $InteractionZone




## Hit and Hurt and Combat
@onready var hurtBox : HurtArea = $HurtArea

## Movement Direction
var direction = Vector2.ZERO

## Gravity
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


## Jump Parameters
var double_jump = false
var jumpBuildVelocity_active = false
var was_on_floor = is_on_floor()
var was_in_air = not is_on_floor()
var was_on_wall = is_on_wall_only()
var onWall = false
var headOnWall = false
var justJumpedBuffer = 13

var just_left_ledge = false
var just_left_wall = false

var canGrabLedge = false

## Wall Jump Parameters
enum WallStates{NOT_ON_WALL, WALL_SLIDING, WALL_HANGING, WALL_JUMPING}
var canWallJump = false
var wall_jumping = false
var wall_hanging = false
var wall_normal
var was_wall_normal
var wall_state = WallStates.NOT_ON_WALL

## Dash Parameters
var can_dash = true

## Crouch
var crouchBuffer = 2

var is_hanging = false
signal died
var hurtPlaying = false

## Random Number Generator for dodge
var dodgeRNG = RandomNumberGenerator.new()

## Called when the node enters the scene tree for the first time.
func _ready():
	updateDefense()
	# If we are debugging the path (Mostly for testing the effects of 
	# gravity changes)
	if debugLine:
		debugPathLine.antialiased = true
		debugPathLine.add_point(global_position)
	
	stateLabel.visible = stateLabelOn
	healthLabel.visible = healthLabelOn
	healthLabel.text = str(health)

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	stateLabel.visible = stateLabelOn
	updateDefense()
	if debugLine:
		update_line()

	
func _physics_process(_delta):
	handle_pass_through()
	wasOn_isOn_justOn()
	


## This Function Updates the checks for what we are near
func wasOn_isOn_justOn():
	just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	just_left_wall = was_on_wall and not onWall
	was_on_floor = is_on_floor()
	was_in_air = not is_on_floor()
	was_on_wall = onWall
	if was_on_wall: 
		was_wall_normal = get_wall_normal()
	## Starting Coyote Time for both Normal and Wall Jump
	if just_left_ledge:
		jump_CoyoteTime.start()
	
	if just_left_wall:
		wall_jump_CoyoteTime.start()
		
	if is_on_floor_only():
		double_jump = false
		wall_jumping = false
		is_hanging = false
		if get_collision_mask_value(pass_through_layer):
			disable_pass_through()
	


	

## This is for the pass-through mechanics.
func handle_pass_through():
	if Input.is_action_just_released(GameContants.UserInputs.MOVE_DOWN):
		disable_pass_through()
	elif Input.is_action_pressed(GameContants.UserInputs.MOVE_DOWN):
		enable_pass_through()


func enable_pass_through():
	set_collision_mask_value(pass_through_layer, false)


## This reenables collisions for said layer.
func disable_pass_through():
	set_collision_mask_value(pass_through_layer, true)
	
func enable_Interact():
	interactZone.set_collision_layer_value(interact_layer, true)


## This reenables collisions for said layer.
func disable_Interact():
	interactZone.set_collision_layer_value(interact_layer, false)


func _on_jump_build_velocity_timeout():
	jumpBuildVelocity_active = false
	

func animTree():
	pass

func updateDefense():
	if hurtBox.defense != defense:
		hurtBox.defense = defense


func update_line():
	# Add the current position to the Line2D points if moved
	if debugPathLine.points.size() == 0 or debugPathLine.points[-1] != global_position:
		debugPathLine.add_point(global_position)


func _on_wall_detector_wall_entered():
	onWall = true
	print(onWall)


func _on_wall_detector_wall_exited():
	onWall = false
	print(onWall)

func _on_head_detector_head_on_wall():
	headOnWall = true # Replace with function body.
	print(headOnWall)


func _on_head_detector_head_off_wall():
	headOnWall = false # Replace with function body.
	print(headOnWall)

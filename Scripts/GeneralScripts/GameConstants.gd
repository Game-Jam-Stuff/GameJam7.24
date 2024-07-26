class_name GameContants
extends Resource


class PlayerAnimations:
	## Player Animations
	const ANIM_IDLE = "Eskil/Idle"
	const ANIM_MOVING = "Eskil/Move"
	const ANIM_DYING = "Eskil/Dying"
	const ANIM_DASHING = "Eskil/Dash"
	const ANIM_JUMPING = "Eskil/Jump"
	const ANIM_FALLING = "Eskil/Fall"
	const ANIM_HANGING = "Eskil/Hang"
	const ANIM_MAGIC = "Eskil/Magic"
	const ANIM_HURT = "Eskil/Hurt"
	

class PlayerStates:
	## Player States
	const IDLE = "IdleState"
	const MOVE = "MoveState"
	const DASH = "DashState"
	const JUMP = "JumpState"
	const WALL = "WallState"
	const CROUCH = "CrouchState"
	const HANG = "HangState"
	const HURT = "WasHurtState"
	const HIT = "AttackState"
	const DEAD = "IsDeadState"


class UserInputs:
	## Inputs
	const MOVE_LEFT = "player_left"
	const MOVE_RIGHT = "player_right"
	const MOVE_UP = "player_up"
	const MOVE_DOWN = "player_down"
	const DASH = "player_dash"
	const JUMP = "player_jump"
	const INTERACT = "player_interact"
	const CROUCH = "player_crouch"
	const SCREENSHOT = "capture_image"
	const DIE = "player_die"
	const CAST = "player_cast"
	const PAUSE = "Pause"

class EnemyAnimations:
	## Enemy Animations
	const ANIM_IDLE = "Idle"
	const ANIM_MOVING = "Move"
	const ANIM_SLASHING = "Attack"
	const ANIM_HURT = "Hit"
	const ANIM_DYING = "Death"

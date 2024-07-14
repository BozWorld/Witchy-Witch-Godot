extends CharacterBody2D

#region Debugging variables
@export var debug: Label
var _debug_text: String
#endregion

@export var anim_player: AnimationPlayer

#region Movement variables
var _speed: float
@export var _base_speed: float = 1000
@export var _max_speed: float = 500
@export var _friction: float = 400
@export var _dashing_friction: float = 700
@export var _modifier: float = 2
var _direction: Vector2 = Vector2(1,0)
var _momentum: Vector2 = Vector2(1,0)
var dot: float
#endregion

#region Dashing variables
var _is_dashing: bool = false
var _dash_direction: Vector2

var _dash_stacks: int = 0
@export var _dash_max_stacks: int = 1

var _dash_cd: float = 0.0
@export var _dash_max_cd: float = 1.0

var _dash_fill_t: float = 2.0
var _dash_fillspeed: float = 2.0

@export var _dash_base_strength: float = 500.0
var _dash_strength: float = 0.0
#endregion

func _ready():
	_speed = _base_speed
	_dash_strength = _dash_base_strength
	_dash_stacks = _dash_max_stacks

func _process(delta):
	#reset debug _debug_text
	_debug_text = ""
	#reset input direction
	_direction = Vector2(0,0)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		_dash()
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_move(delta)
	
	if _dash_cd > 0:
		var clamped_speed: float = _momentum.length()
		_momentum = _momentum.normalized() * (clamped_speed - _dashing_friction * delta)
	else:
		var clamped_speed: float = clampf(_momentum.length(), 0, _max_speed)
		_momentum = _momentum.normalized() * (clamped_speed - _friction * delta)
	
	if _momentum.length() < 4 and _dash_cd <=0 and _direction.length() < 4 :
		_momentum = Vector2(0,0)
	
	velocity = _momentum
	_cooldowns(delta)
	_turn_sprite()

func _physics_process(delta):
	_debug()
	move_and_slide()

func _debug():
	_debug_text += "dot = " + str(snapped(dot, 0.1))
	_debug_text += "\nmomentum = " + str(snapped(_momentum.x, 0.1)) + ", " + str(snapped(_momentum.y, 0.1))
	_debug_text += "\nspeed = " + str(snapped(_momentum.length(), 0.1))
	_debug_text += "\ndirection = " + str(snapped(_direction.x, 0.1)) + ", " + str(snapped(_direction.y, 0.1))
	_debug_text += "\ndashes = " + str(_dash_stacks)
	_debug_text += "\nis dashing = " + str(_dash_cd>0)
	
	debug.text = _debug_text

func _turn_sprite():
	if _momentum.length() < 4:
		return
	var dotdown = Vector2(0,1).dot(_momentum.normalized())
	var dotright = Vector2(1,0).dot(_momentum.normalized())
	
	#_debug_text += "\n"+str(snapped(dotdown,0.001)) + ", " + str(snapped(dotright,0.001))
	
	
	if dotdown > 0.9:
		anim_player.play("South")
		return
	if dotdown < -0.9:
		anim_player.play("North")
		return
	if dotright > 0.9:
		anim_player.play("East")
		return
	if dotright < -0.9:
		anim_player.play("West")
		return
		
	if dotdown > 0.3333:
		if dotright > 0:
			anim_player.play("South_East")
			return
		else:
			anim_player.play("South_West")
			return
	if dotdown < 0.3333:
		if dotright > 0:
			anim_player.play("North_East")
			return
		else:
			anim_player.play("North_West")
			return

func _move(delta):
	if _dash_cd > 0:
		return
	_direction = get_global_mouse_position() - global_position
	if _direction.length() < 4:
		return
	dot = clampf(_modifier - _direction.dot(velocity.normalized()) * (_modifier-1), 0,99999)
	_momentum += _direction.normalized() * _speed * delta

func _dash():
	if _dash_cd > 0 or _dash_stacks <1:
		return
	_dash_direction = position.direction_to(get_global_mouse_position())
	_momentum = _dash_direction * _dash_strength
	_dash_stacks -= 1
	_dash_cd = _dash_max_cd

func _cooldowns(delta: float):
	if _dash_cd > 0:
		_dash_cd -= delta
		
	if _dash_stacks < _dash_max_stacks:
		_dash_fill_t -= delta
		if _dash_fill_t <= 0:
			_dash_fill_t = _dash_fillspeed
			_dash_stacks += 1

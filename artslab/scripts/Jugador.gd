extends CharacterBody2D

#region Debugging variables
@export var debug: Label
var _debug_text: String
#endregion

@export var anim_player: AnimationPlayer
@export var line2d: Line2D

@export var points: int = 30
var currpoint: int = 0

#region Movement variables
var _speed: float
@export var _base_speed: float = 1000
@export var _max_speed: float = 500
@export var _friction: float = 400
@export var _dashing_friction: float = 700
#@export var _modifier: float = 2
var _direction: Vector2 = Vector2(1,0)
var _last_direction: Vector2 = Vector2(0,0)
var _momentum: Vector2 = Vector2(1,0)
#var dot: float
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
	_debug_text = ""  #reset debug _debug_text
	if _direction != Vector2(0,0):
		_last_direction = _direction
	_direction = Vector2(0,0) #reset input direction
	
	read_movement()
	
	if Input.is_action_pressed("dash"):
		dash()
	
	move(delta)
	
	if _dash_cd > 0:
		var clamped_speed: float = _momentum.length()
		_momentum = _momentum.normalized() * (clamped_speed - _dashing_friction * delta)
	else:
		var clamped_speed: float = clampf(_momentum.length(), 0, _max_speed * _direction.length())
		_momentum = _momentum.normalized() * (clamped_speed - _friction * delta * _direction.length())
	
	if _momentum.length() < 4 and _dash_cd <=0 and _direction.length() < 0.1 :
		_momentum = Vector2(0,0)
	
	velocity = _momentum
	cooldowns(delta)
	turn_sprite()
	move_and_slide()

func _physics_process(delta):
	_debug()
	line()
	#move_and_slide()

func _debug():
	if debug == null:
		return
	#_debug_text += "dot = " + str(snapped(dot, 0.1))
	_debug_text += "momentum = " + str(snapped(_momentum.x, 0.1)) + ", " + str(snapped(_momentum.y, 0.1))
	_debug_text += "\nspeed = " + str(snapped(_momentum.length(), 0.1))
	_debug_text += "\ndirection = " + str(snapped(_direction.x, 0.1)) + ", " + str(snapped(_direction.y, 0.1))
	_debug_text += "\ndashes = " + str(_dash_stacks)
	_debug_text += "\nis dashing = " + str(_dash_cd > 0)
	
	debug.text = _debug_text

func turn_sprite():
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

func read_movement():
	var joystick: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if joystick.length() > 0.1:
		_direction = joystick
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_direction = (get_global_mouse_position() - global_position) * 0.1
	_direction = _direction.normalized() * clampf(_direction.length(),0,1)

func move(delta):
	if _dash_cd > 0 or _direction.length() < 0.1:
		return
	_momentum += _direction * _speed * delta

func dash():
	if _dash_cd > 0 or _dash_stacks <1:
		return
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		_dash_direction = (get_global_mouse_position() - global_position).normalized()
	else:
		_dash_direction = _last_direction.normalized()
	_momentum = _dash_direction * _dash_strength
	_dash_stacks -= 1
	_dash_cd = _dash_max_cd

func cooldowns(delta: float):
	if _dash_cd > 0:
		_dash_cd -= delta
		
	if _dash_stacks < _dash_max_stacks:
		_dash_fill_t -= delta
		if _dash_fill_t <= 0:
			_dash_fill_t = _dash_fillspeed
			_dash_stacks += 1

func line():
	line2d.add_point(global_position, currpoint)
	currpoint += 1
	if currpoint > points:
		line2d.remove_point(0)

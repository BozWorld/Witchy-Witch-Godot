extends CharacterBody2D

#region Debugging variables
@export var debug: Label
var _debug_text: String
#endregion

#region Movement variables
var _speed: float
@export var _base_speed: float = 1000
@export var _max_speed: float = 500
@export var _friction: float = 400
@export var _modifier: float = 2
var _direction: Vector2 = Vector2(1,0)
var _momentum: Vector2 = Vector2(1,0)
var dot: float
#endregion

#region Dashing variables
var _is_dashing: bool = false
var _dash_stacks: int = 1
@export var _dash_max_stacks: int = 1
var _dash_cd: float = 0.0
@export var _dash_max_cd: float = 0.0
#endregion

func _ready():
	_speed = _base_speed

func _process(delta):
	#reset debug _debug_text
	_debug_text = ""
	#reset input direction
	_direction = Vector2(0,0)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		if _is_dashing
			return
		if _dash_stacks >0
			dash()
		else
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_direction = global_position.direction_to(get_global_mouse_position())
		dot = clampf(_modifier - _direction.dot(velocity.normalized()) * (_modifier-1), 0,99999)
	
	_momentum += _direction * _speed * delta
	var clamped_speed = clampf(_momentum.length(), 0, _max_speed)
	_momentum = _momentum.normalized() * (clamped_speed - _friction * delta)
	velocity = _momentum
	
	_debug_text += "dot = " + str(dot)
	_debug_text += "\nmomentum = " + str(snapped(_momentum.x, 0.1)) + ", " + str(snapped(_momentum.y, 0.1))
	_debug_text += "\nspeed = " + str( snapped(_momentum.length(), 0.1) )
	debug.text = _debug_text


func _physics_process(delta):
	RayCast2D
	move_and_slide()

extends CharacterBody2D

@export var debug: Label
var text: String

var _current_speed: float = 0
@export var _max_speed: float = 2000
@export var _acceleration: float = 300
@export var _deceleration: float = 6000
@export var _friction: float = 400
@export var _modifier: float = 2
var _direction: Vector2 = Vector2(1,0)
var _momentum: Vector2 = Vector2(1,0)
var dot: float

func _process(delta):
	text = ""
	
	_direction = Vector2(0,0)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_direction = global_position.direction_to(get_global_mouse_position())
		dot = clampf(_modifier - _direction.dot(velocity.normalized()) * (_modifier-1), 0,99999)
		_current_speed = clampf(_current_speed + _acceleration * delta * dot, 0, _max_speed)
	else:
		_current_speed = clampf(_current_speed - _deceleration * delta, 0, _max_speed)
		
	_momentum += _direction * _current_speed * delta
	var clamped_speed = clampf(_momentum.length(), 0, _max_speed)
	_momentum = _momentum.normalized() * (clamped_speed - _friction * delta)
	velocity = _momentum
	
	text += "dot = " + str(dot)
	text += "\nmomentum = " + str(velocity.x) + ", " + str(velocity.y)
	text += "\nspeed = " + str(_current_speed)
	debug.text = text


func _physics_process(delta):
	move_and_slide()

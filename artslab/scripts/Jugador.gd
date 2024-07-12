extends CharacterBody2D

@export var debug: Label
var text: String

@export var _current_speed: float = 1000
@export var _max_speed: float = 500
@export var _friction: float = 400
@export var _modifier: float = 2
var _direction: Vector2 = Vector2(1,0)
var _momentum: Vector2 = Vector2(1,0)
var dot: float
var _is_dashing: bool = false

func _process(delta):
	text = ""
	
	_direction = Vector2(0,0)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_direction = global_position.direction_to(get_global_mouse_position())
		dot = clampf(_modifier - _direction.dot(velocity.normalized()) * (_modifier-1), 0,99999)
	
	_momentum += _direction * _current_speed * delta
	var clamped_speed = clampf(_momentum.length(), 0, _max_speed)
	_momentum = _momentum.normalized() * (clamped_speed - _friction * delta)
	velocity = _momentum
	
	text += "dot = " + str(dot)
	text += "\nmomentum = " + str(snapped(_momentum.x, 0.1)) + ", " + str(snapped(_momentum.y, 0.1))
	text += "\nspeed = " + str( snapped(_momentum.length(), 0.1) )
	debug.text = text


func _physics_process(delta):
	RayCast2D
	move_and_slide()

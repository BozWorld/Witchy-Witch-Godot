extends CharacterBody2D

var _current_speed: float = 0
@export var _max_speed: float = 0
@export var _acceleration: float = 0
@export var _deceleration: float = 0

func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var dir = global_position.direction_to(get_global_mouse_position())
		velocity = dir * _max_speed

func _physics_process(delta):
	move_and_slide()

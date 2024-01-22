extends RigidBody2D

var initial_hit_force = 3000

var max_hit_force = 0
var speed_add = 0
@export var hit_force : float = 0

func _ready():
	#hit_force = 
	pass
	
func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var dir = global_position.direction_to(get_global_mouse_position())
		apply_impulse(hit_force * dir*delta)
		hit_force = initial_hit_force
		max_hit_force = initial_hit_force + ( (hit_force*speed_add)/100)
	if Input.is_key_pressed(KEY_SHIFT):
		speed_add = 100
		hit_force = max_hit_force	
		if hit_force>=max_hit_force :
			print(max_hit_force)
			hit_force = max_hit_force
	else : 
		hit_force = initial_hit_force


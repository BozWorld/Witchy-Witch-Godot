extends CharacterBody2D

var acceleration : Vector2 = Vector2(0,0)
var force : Vector2 = Vector2(0.2,0)
var gravity : Vector2 = Vector2(0,-0.5)
var limit: Vector2 = Vector2(0,0)
var l: Vector2 = Vector2(0,0)

var f : Vector2 = Vector2(0, 0)
var g : Vector2 = Vector2(0,0)
var maxSpeed : Vector2 = Vector2(500,-1)
var mass : float = 0.5
var projectResolution= ProjectSettings.get_setting("display/window/size/viewport_width")

# acceleration += force
# force = mass * time
func _ready() -> void:
	f = force
	g = gravity
	l = limit


func _physics_process(delta: float) -> void:
	force = f/mass
	gravity = g/mass
	limit = l/mass
	acceleration += force + gravity +limit
	velocity += acceleration * delta
	limit = Vector2(0,0)
#	if position.y <= 35 :
#		position.y += 5
#	if position.y >= 750:
#		position.y -=5
#	if position.x >= 750:
#		position.x -=5
#	if position.x <= 45:
#		position.x +=5
	move_and_slide()


#func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
#	l = Vector2(5,-5)
#	velocity *= -1

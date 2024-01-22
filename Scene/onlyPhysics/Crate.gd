extends Sprite2D

var angleVelocity : float = 0
var maxAngleAcceleration: float = 0.05
var acceleration : float = 0.001
var velocity : Vector2 = Vector2(0,0) 
var projectResolution= ProjectSettings.get_setting("display/window/size/viewport_width")


func _physics_process(delta: float) -> void:
	angleVelocity += acceleration
	rotation += angleVelocity
	if angleVelocity >= maxAngleAcceleration:
		angleVelocity =maxAngleAcceleration


#func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
#	l = Vector2(5,-5)
#	velocity *= -1

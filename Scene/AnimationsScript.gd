extends AnimationPlayer

@onready var _animated_sprite = $"Bottom (Aussi Pi)/AnimatedSprite2D"
@onready var _animated_sprite_Placeholder = $"Powertop(clairement pas Pi)/AnimatedMaskPlaceholder"
@onready var _animated_sprite_Scanp = $"Bottom (Aussi Pi)/Scanp"

func logo():
	
	_animated_sprite.play("default")
	
	pass
	
func PlaceholderAnim():
	
	_animated_sprite_Placeholder.play("default")
	
	pass
	
func PlaceholderAnimEnd():
	_animated_sprite_Placeholder.play_backwards("default") 
	pass
	
func _process(_delta):
	
	_animated_sprite_Scanp.play("default")
	
	pass

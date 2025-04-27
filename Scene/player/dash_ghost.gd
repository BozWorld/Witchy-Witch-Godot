extends Sprite2D

func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.5)
	tween.tween_callback(self.queue_free).set_delay(1)
	pass

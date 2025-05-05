extends Sprite2D

func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.hex(0xffc2b378), 0.1)
	tween.tween_property(self, "modulate", Color.hex(0x8c72c278), 0.2)
	tween.tween_property(self, "modulate", Color.hex(0x8c72c200), 0.2)
	tween.tween_callback(self.queue_free).set_delay(1)
	pass

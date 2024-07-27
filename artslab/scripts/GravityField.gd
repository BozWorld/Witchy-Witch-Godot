extends Area2D

#signal grav(field: Area2D)

#func _on_body_entered(body: Node2D) -> void:
	#grav.emit(self)
	#body.send("grav", self)

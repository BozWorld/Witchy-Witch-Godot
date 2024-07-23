extends Line2D

func _physics_process(delta: float) -> void:
	for i in range(0, points.size() -1):
		#var vec = points[i]
		if points[i].distance_to(points[points.size() -1]) < 3 and i < points.size() - 3:
			pass #print_debug("yahoo")

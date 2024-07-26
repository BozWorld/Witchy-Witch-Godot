extends Line2D

var _capt_cd: float = 0
var _capt_max_cd: float = 0.2

func _physics_process(delta: float) -> void:
	if _capt_cd > 0:
		return
	for i in range(0, points.size() -1):
		#var vec = points[i]
		if _capt_cd > 0:
			return
		if points[i].distance_to(points[points.size() -1]) < 2 and i < points.size() - 3:
			#print_debug("yahoo")
			_capt_cd = _capt_max_cd

func _process(delta: float) -> void:
	cooldowns(delta)

func cooldowns(delta: float):
	if _capt_cd > 0:
		_capt_cd -= delta

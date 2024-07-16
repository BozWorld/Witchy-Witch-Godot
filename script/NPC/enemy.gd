extends Node2D
@export var coll : CollisionShape2D
@export var cooldown : Timer
@export var activeFrames : Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	coll.disabled = false
	activeFrames.start(0)
	print("cooldown over")
	pass # Replace with function body.


func _on_timer_2_timeout():
	coll.disabled = true
	cooldown.start(0)
	print("attack over")
	pass # Replace with function body.

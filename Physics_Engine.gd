extends Node2D

var angle : float = 0
var angleVelocity : float = 0
var angleAcceleration: float = 5
var acceleration : Vector2 = Vector2(0,0)
var velocity : Vector2 = Vector2(0,0) 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation += angleVelocity
	pass

func _draw() -> void:
	draw_line(Vector2(200, 400), Vector2(600, 400), Color.AQUAMARINE, 5)
	draw_circle(Vector2(200,400),10,Color.AQUAMARINE)
	draw_circle(Vector2(600, 400),10,Color.AQUAMARINE)

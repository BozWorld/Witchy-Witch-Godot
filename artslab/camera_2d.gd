extends Camera2D

@export var player:CharacterBody2D

@export var true_position: Vector2
@export var subpixel_position: Vector2

func _process (delta: float) -> void:

	true_position = true_position.lerp(player.position, delta *5)
	subpixel_position = true_position.round() - true_position
	subpixel_position = (subpixel_position * 4).round() / 4
	RenderingServer.global_shader_parameter_set("cam_offset", subpixel_position )
	global_position = true_position#.round()

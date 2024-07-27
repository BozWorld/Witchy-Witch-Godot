extends Area2D

#signal grav(field: Area2D)
@export var player:CharacterBody2D

func _process(delta: float) -> void:
	player.velocity += (global_position - player.global_position).normalized() * 90000 * delta

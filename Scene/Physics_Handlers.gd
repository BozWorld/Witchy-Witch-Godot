extends Node2D

@export var player_scene: PackedScene
@export var spawn_location: PathFollow2D
@export var SpawnTimer: Timer
@export var StopTimer: int = 0
var randomValue = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	randomValue= randf_range(0.4,0.8)
	if StopTimer >= 10 :
		SpawnTimer.stop()
	pass
	

func _on_spawn_timer_timeout() -> void:
	var player = player_scene.instantiate()
	player.scale = Vector2(randomValue,randomValue)
	spawn_location.progress_ratio = randf()
	player.position = spawn_location.position - Vector2(0,40)
	player.mass = randf_range(0.5,5)
	StopTimer +=1
	add_child(player)

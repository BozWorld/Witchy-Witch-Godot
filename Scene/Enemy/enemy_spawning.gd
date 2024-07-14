extends Node2D

@export var mob_scene: PackedScene
var spawnPoints : Array = []
var rand = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _spawn():
	var screenSize = get_viewport().get_visible_rect()
	spawnPoints[0] = Vector2( screenSize.x/4, 3*screenSize.y/4 ) #SouthWest
	spawnPoints[1] = Vector2( 3*screenSize.x/4, 3*screenSize.y/4 ) #SouthEast
	spawnPoints[2] = Vector2( screenSize.x/4, screenSize.y/4 ) #NorthWest
	spawnPoints[3] = Vector2( 3*screenSize.x/4, screenSize.y/4 ) #NorthEast
	var newPosition = rand.randi_range(0,3)
	
	var mob = mob_scene.instantiate()
	mob.globalPosition = spawnPoints[newPosition]
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

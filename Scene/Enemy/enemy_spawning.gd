extends Node2D

@export var mob_scene: PackedScene
@export var averageSpawnCooldown: float
var spawnCooldown : float
var spawnPoints : Array = [0,0,0,0]
var rand = RandomNumberGenerator.new()
var oldPositions: Array = [false,false,false,false]
# Called when the node enters the scene tree for the first time.
func _ready():
	var screenSize = get_viewport().get_visible_rect().size
	spawnPoints[0] = Vector2( screenSize.x/4, 3*screenSize.y/4 ) #SouthWest
	spawnPoints[1] = Vector2( 3*screenSize.x/4, 3*screenSize.y/4 ) #SouthEast
	spawnPoints[2] = Vector2( screenSize.x/4, screenSize.y/4 ) #NorthWest
	spawnPoints[3] = Vector2( 3*screenSize.x/4, screenSize.y/4 ) #NorthEast
	pass # Replace with function body.
func _spawn():

	var newPosition = rand.randi_range(0,3)
	if (oldPositions[newPosition]):
		return
	var mob = mob_scene.instantiate()
	mob.position = spawnPoints[newPosition]
	oldPositions[newPosition]=true
	add_child(mob)
	
	spawnCooldown= averageSpawnCooldown+rand.randf_range(-1,1)
	

# Called every frame.. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawnCooldown-=delta
	if (spawnCooldown<=0):
		_spawn()
	pass
func _mobDeath(deathPosition):
	for n in spawnPoints.size():
		if (spawnPoints[n-1]==deathPosition):
			oldPositions[n-1]=false 
	pass

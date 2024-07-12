extends Node2D

@onready var velocityLab = $UI/velocity
@onready var massLab = $UI/mass
@onready var AngularLab = $"UI/Angular Drag"
@onready var player = $Player_Body
@onready var player_sprite = $Player_Body/SpritePlayer
@onready var forceLab = $UI/force
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocityLab.text = str( str("velocity : ") + str(player.linear_velocity))
	massLab.text =  "mass : " + str( player.mass )
	AngularLab.text = "AngularDamp : " + str( player.angular_damp )
	forceLab.text = "force : " + str( player.hit_force)

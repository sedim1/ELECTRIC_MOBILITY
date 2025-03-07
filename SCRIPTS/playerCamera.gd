class_name PlayerCamera
extends Camera3D

@export var player : Player

@export var FOLLOWSPEED : float = 300.0
@export var height : float = 10.3
@export var distance : float = 6.3
var canFollow : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Player camera movement
func followPlayerPosition(delta:float) -> Vector3:
	var dest : Vector3
	#Calculate destination
	dest.y = height
	#dest.x = player.global_position.x
	dest.x = move_toward(global_position.x,player.global_position.x,delta)
	dest.z = player.global_position.z + distance
	return dest


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player != null:
		global_position = followPlayerPosition(FOLLOWSPEED)
	pass

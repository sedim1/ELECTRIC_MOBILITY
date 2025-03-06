extends Node3D

var angle : float
@export var angleSpeed : float = 0.1
@export var r : float = 5.0
var t : float = 0.0

# The parametric equation of a circle is x = r cos(t) and y = r sin(t),
func rotateAsteroids() -> void:
	for asteroid : StaticBody3D in get_children():
		#rotate around node3d position
		var offset : Vector3 = asteroid.global_position - global_position
		offset = offset.rotated(Vector3.UP,0.01)
		asteroid.global_position = global_position + offset

func setRingRadious() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotateAsteroids()
	pass

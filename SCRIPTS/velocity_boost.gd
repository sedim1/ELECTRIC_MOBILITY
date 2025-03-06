class_name BoostAccelerator
extends Area3D

@export var speedBoost : float = 10.0
var rotSpeed : float = 5
var boost : float
var t : float = 0.0;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	boost = speedBoost
	#print("Speed boost: "+str(boost))
	pass # Replace with function body.


func playAnimation() -> void:
	t+=0.2
	rotation_degrees.y += rotSpeed
	#offset = sin(t) * 0.5
	position.y = sin(t) * 0.1
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	playAnimation()
	pass


func increaseVelocityPlayer(body:Node3D) -> void:
	if body is Player:
		#print("Increase speed!!!")
		body.increaseSpeed(boost)
		body.isBoosting = true
		queue_free()

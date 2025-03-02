class_name BoostAccelerator
extends Area3D

@export var speedBoost : float = 10.0
var boost : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	boost = speedBoost
	print("Speed boost: "+str(boost))
	pass # Replace with function body.


func playAnimation() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	playAnimation()
	pass


func increaseVelocityPlayer(body:Node3D) -> void:
	if body is Player:
		print("Increase speed!!!")
		body.increaseSpeed(boost)
		queue_free()

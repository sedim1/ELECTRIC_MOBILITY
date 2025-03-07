class_name  WINAREA
extends Area3D

var playerEntered : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerEntered = false
	pass # Replace with function body.




func _on_body_entered(body:Node3D) -> void:
	if body is Player:
		body.currentState = body.playerStates.STOPPING
		playerEntered = true
		$AudioStreamPlayer.play()
	pass # Replace with function body.

extends Control

@export var p : Player
@onready var speedCounter : Label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func getPlayerSpeed():
	if p != null:
		speedCounter.text = str(int(p.speed)) + " m/s"
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	getPlayerSpeed()
	pass

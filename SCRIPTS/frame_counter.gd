extends Control

var frames : int
var FPS : int
@export var counter : Label
var lastTime = 0
var currentTime

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	FPS = 0
	frames = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	frames += 1
	counter.text = "FPS: " + str(FPS)
	pass

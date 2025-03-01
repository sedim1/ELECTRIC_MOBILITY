extends Control

var frames : int
var FPS : int
var lastTime = 0
@export var textCounter : Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	FPS = 0
	frames = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	frames += 1
	var currentTime = Time.get_ticks_msec()
	if currentTime - lastTime >= 1000:
		FPS = frames
		lastTime = currentTime
		frames = 0
	textCounter.text = "FPS: " + str(FPS)
	pass

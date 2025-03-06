extends Path3D
 
@export var asteroidSteps = 0.3
@export var spawnTimer = 1000
var asteroidScene = preload("res://SCENES/following_asteroid.tscn")
var asteroidInstance
var lastTime = 0
var currentTime = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	asteroidInstance = asteroidScene.instantiate()
	asteroidInstance.steps = asteroidSteps
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	currentTime = Time.get_ticks_msec()
	if currentTime - lastTime >= spawnTimer:
		asteroidInstance = asteroidScene.instantiate()
		asteroidInstance.steps = asteroidSteps
		add_child(asteroidInstance)
		lastTime = currentTime
		#print("add")
	pass

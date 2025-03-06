extends PathFollow3D

enum statePath {MOVING,FINISHED}
var state : statePath
var steps : float =  0.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = statePath.MOVING
	progress_ratio = 0
	#print("Moving steps: " + str(steps))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if state == statePath.MOVING:
		progress_ratio += steps * delta
		if progress_ratio >= 1.0:
			state = statePath.FINISHED
	elif state == statePath.FINISHED:
		queue_free()
	pass

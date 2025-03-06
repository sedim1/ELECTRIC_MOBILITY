extends Node3D

enum WorldState {PREPARE,PLAY,WIN,LOSS}
var state : WorldState
var timer : int = 3
var currentTime = 0
var lastTime = 0
@export var character : Player



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = WorldState.PREPARE
	timer = 4
	currentTime = 0
	lastTime = 0

func prepareState() -> void:
	currentTime = Time.get_ticks_msec()
	if currentTime - lastTime >= 1:
		if timer != 0:
			print(timer)
			lastTime = currentTime
			timer -= 1
		else:
			print("GO!")
			character.currentState = character.playerStates.MOVING
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

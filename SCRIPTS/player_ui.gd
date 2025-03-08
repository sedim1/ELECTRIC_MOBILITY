class_name PLAYERUI
extends Control

enum States {READY,COUNTDOWN,PLAYING}
var UISTATE : States

@export var p : Player
@onready var speedCounter : Label = $Label
@onready var skipText : Label = $Label2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UISTATE = States.READY

	pass # Replace with function body.

func getPlayerSpeed():
	if p != null:
		speedCounter.text = "ENERGY:\n" + str(int(p.speed))
	pass

func countDownUI( t : String) -> void:
	speedCounter.text = t


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if UISTATE == States.READY:
		skipText.text = "START NOW - ENTER"
		speedCounter.text = "READY?"
	elif UISTATE == States.COUNTDOWN:
		skipText.text = ""
		pass
	elif UISTATE == States.PLAYING:
		skipText.text = "RESTART - R"
		getPlayerSpeed()
		pass
	pass

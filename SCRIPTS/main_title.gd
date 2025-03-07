extends Node3D

enum STATES {LOADTITLE,LOAD_FIRST_LEVEL}
var state : STATES
@export var firstLevel : String
@onready var fadeTransitions : Transition = $Transition
@onready var modelAsteroid : StaticBody3D = $Asteroid
@onready var modelCharacter : PathFollow3D = $Path3D/Model


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = STATES.LOADTITLE
	pass # Replace with function body.

func loadFirstLevel() -> void:
	if not fadeTransitions.animation_player.is_playing() and not firstLevel.is_empty():
		get_tree().change_scene_to_file(firstLevel)

func loadTitleState() -> void:
	if not fadeTransitions.animation_player.is_playing() and Input.is_action_pressed("ui_accept"):
		state = STATES.LOAD_FIRST_LEVEL
		fadeTransitions.transitionFadeToBlack()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("close"):
		print("Exiting Game")
		get_tree().quit()
	
	modelCharacter.progress_ratio += 0.5 * delta

	modelAsteroid.rotation_degrees.y += 0.9
	if state == STATES.LOADTITLE:
		loadTitleState()
	elif state == STATES.LOAD_FIRST_LEVEL:
		loadFirstLevel()
	pass

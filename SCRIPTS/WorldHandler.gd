extends Node3D

enum WorldState {INITIAL_STATE,PREPARE,PLAY,WIN,LOSS,SHOW_LEVEL}

@export var nextLevel : String
var state : WorldState
var timer : int = 5
var currentTime = 0
var lastTime = 0
@export var character : Player

@onready var transitions : Transition = $Transition
@onready var ui : PLAYERUI = $PlayerUI
@onready var objective : WINAREA = $WinArea
@onready var cam : PlayerCamera = $Camera3D
@onready var camPath : CameraPath = $CameraPath


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cam.current = false
	camPath.enableCamera()
	ui.UISTATE = ui.States.READY
	state = WorldState.INITIAL_STATE
	timer = 3
	currentTime = 0
	lastTime = 0

func startScene() -> void:
	if not transitions.animation_player.is_playing():
		camPath.start = true
		state = WorldState.SHOW_LEVEL
		print("PREPARE YOURSELF")
	pass

func restartScene() -> void:
	if not transitions.animation_player.is_playing():
		print("ReloadingLevel")
		get_tree().reload_current_scene()
	pass

func showLevel() -> void:
	if camPath.isFinished or Input.is_action_just_pressed("ui_accept"):
		ui.UISTATE = ui.States.COUNTDOWN
		state = WorldState.PREPARE
		cam.current = true
		camPath.disableCamera()
	pass

func loadNextLevel() -> void:
	if not transitions.animation_player.is_playing():
		if nextLevel.is_empty():
			print("No Next level")
			get_tree().change_scene_to_file("res://SCENES/ending.tscn")
			pass
		else:
			print("Loading next level...")
			get_tree().change_scene_to_file(nextLevel)

func prepareState() -> void:
	currentTime = Time.get_ticks_msec()
	if currentTime - lastTime >= 1000:
		if timer != 0:
			ui.countDownUI(str(timer))
			print(timer)
			lastTime = currentTime
			timer -= 1
		else:
			print("GO!")
			camPath.disableCamera()
			cam.current = true
			character.setInitialVelocity()
			cam.canFollow = true
			ui.UISTATE = ui.States.PLAYING
			state = WorldState.PLAY
	pass

func playingState() -> void:
	if objective.playerEntered:
		state = WorldState.WIN
		transitions.transitionFadeToBlack()
	elif character.currentState == character.playerStates.STOPPING or Input.is_action_pressed("reset"):
		state = WorldState.LOSS
		transitions.transitionFadeToBlack()
		pass
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("close"):
		print("Exiting Game")
		get_tree().quit()

	if state == WorldState.INITIAL_STATE:
		startScene()
	elif state == WorldState.SHOW_LEVEL:
		showLevel()
	elif state == WorldState.PREPARE:
		prepareState()
	elif state == WorldState.PLAY:
		playingState()
	elif state == WorldState.LOSS:
		restartScene()
	elif state == WorldState.WIN:
		loadNextLevel()
	pass

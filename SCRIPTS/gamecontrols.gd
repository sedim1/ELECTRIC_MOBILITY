extends Node3D

@onready var robot : Player = $Player
@onready var t : Transition = $Transition
var startGame : bool = false
var currentTime = 0

func _ready() -> void:
    $Player/Robot/CHARACTER/AnimationPlayer.play("Accelerating")
    robot.currentState = robot.playerStates.SHOWCASE

func _process(delta: float) -> void:
    if Input.is_action_just_pressed("close"):
        get_tree().quit()
    if not startGame:
        if not t.animation_player.is_playing():
            if Input.is_action_just_pressed("ui_accept"):
                t.transitionFadeToBlack()
                startGame = true
        pass
    else:
        if not t.animation_player.is_playing():
            get_tree().change_scene_to_file("res://SCENES/level_easy.tscn")
        pass

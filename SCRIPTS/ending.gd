extends Node3D

var currentTime = 0
var lastTime = 0
var  canRestart : bool = false
var mainTitlePath : String = "res://SCENES/MainTitle.tscn"

@onready var t : Transition = $Transition

func _process(delta: float) -> void:
	if Input.is_action_pressed("close"):
		print("Exiting Game")
		get_tree().quit()
	if canRestart:
		if not t.animation_player.is_playing():
			print("Go to main title scene")
			get_tree().change_scene_to_file(mainTitlePath)
		pass
	else:
		currentTime = Time.get_ticks_msec()
		if currentTime - lastTime >= 5000:
			canRestart = true
			t.transitionFadeToBlack()
	pass
